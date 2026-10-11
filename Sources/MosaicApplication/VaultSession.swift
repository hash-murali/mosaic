import Foundation
import MosaicCore
import MosaicDomain
import MosaicPolicy
import MosaicStorage

public enum SessionFailure: Error, Equatable, Sendable {
    case locked, cancelled, authenticationUnavailable, authenticationDenied, keyUnavailable
    case invalidConfiguration, retryRequired, pageLimitReached
    case keyNotFound, keySigningUnavailable, keyAccessDenied, keyInteractionUnavailable
    case invalidKeyMaterial, keyOperationFailed(Int32), nativeAppRequired
}

/// Platform key release must authenticate; test adapters contain synthetic keys only.
public protocol VaultKeyCustody: Sendable {
    func create(vaultID: UUID) async throws -> Data
    func unlock(vaultID: UUID) async throws -> Data
    func cancel() async
}
public protocol VaultOCR: Sendable {
    func recognize(_ source: Data) async throws -> String
}
public struct LocalVaultOCR: VaultOCR {
    public init() {}
    public func recognize(_ source: Data) async throws -> String {
        let worker = Task.detached {
            try Task.checkCancellation()
            let pixels = try BoundedImageImport.decode(source)
            try Task.checkCancellation()
            let text = try ImageOCR.recognize(pixels).text
            try Task.checkCancellation()
            return text
        }
        return try await withTaskCancellationHandler { try await worker.value } onCancel: { worker.cancel() }
    }
}

/// Authenticated application composition. No key retained by this service after
/// open, and no content returned by a superseded/locked async operation.
public actor VaultSession {
    private let url: URL
    private let vaultID: VaultID
    private let owner: PrincipalID
    private let custody: any VaultKeyCustody
    private let ocr: any VaultOCR
    private var vault: ProtectedVault?
    private var epoch = UUID()
    private var processingEpoch: UUID?
    private var worker: Task<String, Error>?
    private let retryDelay: @Sendable (Int) async throws -> Void

    public init(url: URL, vaultID: UUID, ownerID: UUID, custody: any VaultKeyCustody,
                ocr: any VaultOCR = LocalVaultOCR(),
                retryDelay: @escaping @Sendable (Int) async throws -> Void = { attempt in
                    try await Task.sleep(for: .milliseconds(100 * (1 << attempt)))
                }) {
        self.url = url
        self.vaultID = VaultID(vaultID)
        owner = PrincipalID(ownerID)
        self.custody = custody
        self.ocr = ocr
        self.retryDelay = retryDelay
    }
    public func open(create: Bool) async throws {
        guard vault == nil else { return }
        let ticket = UUID()
        epoch = ticket
        let key = try await (create ? custody.create(vaultID: vaultID.rawValue) : custody.unlock(vaultID: vaultID.rawValue))
        guard ticket == epoch, !Task.isCancelled else { throw SessionFailure.cancelled }
        guard key.count == 32 else { throw SessionFailure.keyUnavailable }
        vault = try ProtectedVault(url: url, key: key, vaultID: vaultID, authenticatedOwner: owner, create: create)
    }
    public func lock() async {
        epoch = UUID()
        worker?.cancel()
        worker = nil
        processingEpoch = nil
        let closing = vault
        vault = nil
        await closing?.lock() // invalidate storage authority before cancelling authentication
        await custody.cancel()
    }
    private func current() throws -> (ProtectedVault, UUID) {
        guard let vault else { throw SessionFailure.locked }
        return (vault, epoch)
    }
    private func ensure(_ ticket: UUID) throws {
        guard ticket == epoch, vault != nil, !Task.isCancelled else { throw SessionFailure.cancelled }
    }
    private func grant(_ vault: ProtectedVault, _ operation: ContentOperation, _ purpose: AccessPurpose,
                       _ ids: Set<ContentRecordID>, _ fields: Set<ContentField>) async throws -> AuthorizedContentContext {
        let request = try ContentAccessRequest(vaultID: vaultID, operation: operation, purpose: purpose, records: ids, fields: fields)
        return try await vault.authorize(principalID: owner, request: request, expiresAt: Date().addingTimeInterval(60))
    }
    public func page(after: UUID? = nil) async throws -> [StoredCapture] {
        let (vault, ticket) = try current()
        let catalog = try await vault.authorizeCatalog(principalID: owner, pageLimit: 100, expiresAt: Date().addingTimeInterval(60))
        try ensure(ticket)
        let ids = try await vault.catalog(after: after.map(ContentRecordID.init), context: catalog)
        await vault.revokeCatalog(catalog)
        var captures: [StoredCapture] = []
        for id in ids {
            try ensure(ticket)
            let context = try await grant(vault, .read, .ownerReview, [id], [.source, .observation, .correction])
            let capture = try await vault.capture(id: id, context: context)
            await vault.revoke(context)
            try ensure(ticket)
            captures.append(capture)
        }
        return captures
    }
    public func receive(_ source: Data) async throws -> UUID {
        let (vault, ticket) = try current()
        _ = try BoundedImageImport.decode(source) // validate type/budgets before durable acceptance
        let catalog = try await vault.authorizeCatalog(principalID: owner, pageLimit: 100, expiresAt: Date().addingTimeInterval(60))
        let existing = try await vault.catalog(after: nil, context: catalog)
        await vault.revokeCatalog(catalog)
        // Initial UI is bounded to 100 captures; no invisible unbounded session.
        guard existing.count < 100 else { throw SessionFailure.pageLimitReached }
        let proposed = ContentRecordID(UUID())
        let context = try await grant(vault, .capture, .ownerCapture, Set(existing + [proposed]), [.source])
        try ensure(ticket)
        let id = try await vault.receive(source: source, proposedID: proposed, context: context)
        await vault.revoke(context)
        try ensure(ticket)
        return id.rawValue
    }
    public func source(_ id: UUID) async throws -> Data {
        let (vault, ticket) = try current()
        let id = ContentRecordID(id)
        let context = try await grant(vault, .read, .ownerReview, [id], [.source])
        try ensure(ticket)
        let bytes = try await vault.source(id: id, context: context)
        await vault.revoke(context)
        try ensure(ticket)
        return bytes
    }
    /// One foreground worker, resumes only durable received-stage captures.
    /// Cancellation/lock leaves the source and checkpoint for the next session.
    public func resumeProcessing() async throws {
        let (vault, ticket) = try current()
        guard processingEpoch != ticket else { return }
        processingEpoch = ticket
        defer { if processingEpoch == ticket { processingEpoch = nil; worker = nil } }
        let pending = try await page().filter { $0.needsProcessing && !$0.retryRequired }
        for capture in pending {
            try ensure(ticket)
            let bytes = try await source(capture.id)
            let id = ContentRecordID(capture.id)
            var attempts = capture.processingAttempts
            while attempts < 3 {
                let text: String
                let ocr = ocr
                let running = Task { try await ocr.recognize(bytes) }
                worker = running
                do {
                    text = try await withTaskCancellationHandler { try await running.value } onCancel: { running.cancel() }
                }
                catch {
                    try ensure(ticket) // lock/cancellation never consumes a failure attempt
                    let failure = try await grant(vault, .process, .ownerProcessing, [id], [.processingState])
                    try ensure(ticket)
                    try await vault.recordProcessingFailure(id: id, context: failure)
                    await vault.revoke(failure)
                    attempts += 1
                    if attempts < 3 { try await retryDelay(attempts) }
                    continue
                }
                try ensure(ticket)
                let context = try await grant(vault, .process, .ownerProcessing, [id], [.observation])
                try ensure(ticket)
                try await vault.saveObservation(id: id, text: text, context: context)
                await vault.revoke(context)
                try ensure(ticket)
                break
            }
        }
    }
    public func retry(_ id: UUID) async throws {
        let (vault, ticket) = try current()
        let id = ContentRecordID(id)
        let context = try await grant(vault, .process, .ownerProcessing, [id], [.processingState])
        try ensure(ticket)
        try await vault.retryProcessing(id: id, context: context)
        await vault.revoke(context)
        try ensure(ticket)
    }
    public func search(_ text: String) async throws -> [UUID] {
        let (vault, ticket) = try current()
        let catalog = try await vault.authorizeCatalog(principalID: owner, pageLimit: 100, expiresAt: Date().addingTimeInterval(60))
        let ids = try await vault.catalog(after: nil, context: catalog)
        await vault.revokeCatalog(catalog)
        try ensure(ticket)
        guard !ids.isEmpty else { return [] }
        let context = try await grant(vault, .search, .ownerSearch, Set(ids), [.correction])
        try ensure(ticket)
        let matches = try await vault.search(text, context: context)
        await vault.revoke(context)
        try ensure(ticket)
        return matches.map(\.rawValue)
    }
    public func snapshot(to destination: URL, recoveryKey: Data) async throws {
        let (vault, ticket) = try current()
        let captures = try await page()
        let context = try await grant(vault, .backup, .ownerBackup,
            Set(captures.map { ContentRecordID($0.id) }), [.source, .observation, .correction, .processingState])
        try ensure(ticket)
        try await vault.snapshot(to: destination, recoveryKey: recoveryKey, context: context)
        await vault.revoke(context)
        try ensure(ticket)
    }
    public func rebuildSearchIndex() async throws {
        let (vault, ticket) = try current()
        let captures = try await page()
        let context = try await grant(vault, .process, .ownerProcessing,
            Set(captures.map { ContentRecordID($0.id) }), [.correction])
        try ensure(ticket)
        try await vault.rebuildSearchIndex(context: context)
        await vault.revoke(context)
        try ensure(ticket)
    }
    /// Recovery requires possession of the independent key and authenticated
    /// platform custody for the destination. Never falls back to the source key.
    public static func restore(snapshot: URL, recoveryKey: Data, destination: URL,
                               custody: any VaultKeyCustody) async throws -> (vaultID: UUID, ownerID: UUID) {
        guard snapshot.isFileURL, destination.isFileURL, snapshot != destination,
              !FileManager.default.fileExists(atPath: destination.path), recoveryKey.count == 32 else {
            throw SessionFailure.invalidConfiguration
        }
        let recovered = try EncryptedVault(url: snapshot, key: recoveryKey, create: false, readOnly: true)
        do {
            let identity = try await recovered.identity()
            let restoredVaultID = UUID()
            let destinationKey = try await custody.create(vaultID: restoredVaultID)
            try Task.checkCancellation()
            // Verify every source hash before publishing a restored destination.
            try await recovered.validateAllSources()
            try await recovered.snapshot(to: destination, recoveryKey: destinationKey, destinationVaultID: restoredVaultID)
            await recovered.lock()
            return (restoredVaultID, identity.ownerID)
        } catch { await recovered.lock(); throw error }
    }
    public func save(_ id: UUID, text: String, revision: Int) async throws {
        let (vault, ticket) = try current()
        let id = ContentRecordID(id)
        let context = try await grant(vault, .correct, .ownerReview, [id], [.correction])
        try ensure(ticket)
        try await vault.approve(id: id, text: text, expectedRevision: revision, context: context)
        await vault.revoke(context)
        try ensure(ticket)
    }
    public func discard(_ id: UUID, revision: Int) async throws {
        let (vault, ticket) = try current()
        let id = ContentRecordID(id)
        let context = try await grant(vault, .delete, .ownerReview, [id], [.source, .observation, .correction])
        try ensure(ticket)
        try await vault.delete(id: id, expectedRevision: revision, context: context)
        await vault.revoke(context)
        try ensure(ticket)
    }
}
