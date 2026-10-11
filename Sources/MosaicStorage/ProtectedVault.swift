import Foundation
import MosaicDomain
import MosaicPolicy

/// Application content boundary: policy validation and SQLite commit execute on
/// one actor without suspension, so a queued lock cannot race a checked commit.
/// Construction is trusted composition AFTER owner authentication/key release;
/// principal IDs alone are not authentication. OS key custody is not yet wired.
public actor ProtectedVault {
    private let database: EncryptedDatabase
    private var policy: OwnerPolicyState

    public init(url: URL, key: Data, vaultID: VaultID, authenticatedOwner: PrincipalID,
                create: Bool, now: @escaping @Sendable () -> Date = { Date() }) throws {
        database = try EncryptedDatabase(url: url, key: key, create: create)
        try database.bindIdentity(vaultID: vaultID.rawValue, ownerID: authenticatedOwner.rawValue, create: create)
        policy = OwnerPolicyState(vaultID: vaultID, ownerID: authenticatedOwner, now: now)
        try policy.beginOwnerSession(principalID: authenticatedOwner)
    }

    public func authorize(principalID: PrincipalID, request: ContentAccessRequest,
                          expiresAt: Date) throws -> AuthorizedContentContext {
        try policy.authorize(principalID: principalID, request: request, expiresAt: expiresAt)
    }

    public func authorizeCatalog(principalID: PrincipalID, pageLimit: Int,
                                 expiresAt: Date) throws -> AuthorizedCatalogContext {
        try policy.authorizeCatalog(principalID: principalID, pageLimit: pageLimit, expiresAt: expiresAt)
    }
    public func catalog(after: ContentRecordID?, context: AuthorizedCatalogContext) throws -> [ContentRecordID] {
        try policy.validateCatalog(context)
        return try database.catalog(after: after?.rawValue, limit: context.pageLimit).map(ContentRecordID.init)
    }

    public func revoke(_ context: AuthorizedContentContext) { policy.revoke(context) }
    public func revokeCatalog(_ context: AuthorizedCatalogContext) { policy.revokeCatalog(context) }

    public func lock() {
        policy.invalidateSession()
        database.lock()
    }

    private func check(_ context: AuthorizedContentContext, operation: ContentOperation,
                       purpose: AccessPurpose, ids: Set<ContentRecordID>, fields: Set<ContentField>) throws {
        let request = try ContentAccessRequest(vaultID: context.request.vaultID, operation: operation,
            purpose: purpose, records: ids, fields: fields)
        try policy.validate(context, for: request)
    }

    public func receive(source: Data, proposedID: ContentRecordID,
                        context: AuthorizedContentContext) throws -> ContentRecordID {
        try check(context, operation: .capture, purpose: .ownerCapture, ids: [proposedID], fields: [.source])
        return ContentRecordID(try database.receive(source: source, proposedID: proposedID.rawValue,
            allowedExistingIDs: Set(context.request.records.map(\.rawValue))))
    }

    public func source(id: ContentRecordID, context: AuthorizedContentContext) throws -> Data {
        try check(context, operation: .read, purpose: .ownerReview, ids: [id], fields: [.source])
        return try database.source(id: id.rawValue)
    }

    public func capture(id: ContentRecordID, context: AuthorizedContentContext) throws -> StoredCapture {
        try check(context, operation: .read, purpose: .ownerReview, ids: [id], fields: [.source, .observation, .correction])
        return try database.capture(id: id.rawValue)
    }

    public func saveObservation(id: ContentRecordID, text: String, context: AuthorizedContentContext) throws {
        try check(context, operation: .process, purpose: .ownerProcessing, ids: [id], fields: [.observation])
        try database.saveObservation(id: id.rawValue, text: text)
    }

    public func recordProcessingFailure(id: ContentRecordID, context: AuthorizedContentContext) throws {
        try check(context, operation: .process, purpose: .ownerProcessing, ids: [id], fields: [.processingState])
        try database.recordProcessingFailure(id: id.rawValue)
    }
    public func retryProcessing(id: ContentRecordID, context: AuthorizedContentContext) throws {
        try check(context, operation: .process, purpose: .ownerProcessing, ids: [id], fields: [.processingState])
        try database.retryProcessing(id: id.rawValue)
    }

    public func approve(id: ContentRecordID, text: String, expectedRevision: Int,
                        context: AuthorizedContentContext) throws {
        try check(context, operation: .correct, purpose: .ownerReview, ids: [id], fields: [.correction])
        try database.approve(id: id.rawValue, text: text, expectedRevision: expectedRevision)
    }

    public func search(_ query: String, context: AuthorizedContentContext) throws -> [ContentRecordID] {
        try check(context, operation: .search, purpose: .ownerSearch,
            ids: context.request.records, fields: [.correction])
        return try database.search(query, allowedIDs: Set(context.request.records.map(\.rawValue)))
            .map(ContentRecordID.init)
    }

    private func completeScope(_ context: AuthorizedContentContext, operation: ContentOperation,
                               purpose: AccessPurpose, fields: Set<ContentField>) throws {
        // Whole-store operations require an explicit complete capture scope.
        let ids = try database.catalog(after: nil, limit: 100)
        guard !ids.isEmpty,
              try database.catalog(after: ids.last, limit: 1).isEmpty else { throw VaultStorageFailure.invalidInput }
        let scope = Set(ids.map(ContentRecordID.init))
        try check(context, operation: operation, purpose: purpose, ids: scope, fields: fields)
    }
    public func snapshot(to destination: URL, recoveryKey: Data, context: AuthorizedContentContext) throws {
        // Validate authority before even consulting the identity catalog.
        try check(context, operation: .backup, purpose: .ownerBackup,
            ids: context.request.records, fields: [.source, .observation, .correction, .processingState])
        try completeScope(context, operation: .backup, purpose: .ownerBackup,
            fields: [.source, .observation, .correction, .processingState])
        try database.snapshot(to: destination, recoveryKey: recoveryKey)
    }
    public func rebuildSearchIndex(context: AuthorizedContentContext) throws {
        try check(context, operation: .process, purpose: .ownerProcessing,
            ids: context.request.records, fields: [.correction])
        try completeScope(context, operation: .process, purpose: .ownerProcessing, fields: [.correction])
        try database.rebuildSearchIndex()
    }

    public func delete(id: ContentRecordID, expectedRevision: Int, context: AuthorizedContentContext) throws {
        try check(context, operation: .delete, purpose: .ownerReview, ids: [id], fields: [.source, .observation, .correction])
        try database.delete(id: id.rawValue, expectedRevision: expectedRevision)
    }
}
