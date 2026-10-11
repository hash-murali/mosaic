import Foundation
import MosaicDomain

/// Policy-issued, process-local authority. Not serializable or constructible by clients.
public struct AuthorizedContentContext: Sendable {
    fileprivate let token: UUID
    public let principalID: PrincipalID
    public let request: ContentAccessRequest
    public let sessionID: UUID
    public let expiresAt: Date
}

/// Explicit bounded identity-catalog authority, not an implicit content wildcard.
public struct AuthorizedCatalogContext: Sendable {
    fileprivate let token: UUID
    public let vaultID: VaultID
    public let principalID: PrincipalID
    public let sessionID: UUID
    public let expiresAt: Date
    public let pageLimit: Int
}

/// Owner-only policy primitive, not authentication, encryption or an app lock.
/// A future trusted application service authenticates before opening a session.
public struct OwnerPolicyState: Sendable {
    private let vaultID: VaultID
    private let ownerID: PrincipalID
    private let now: @Sendable () -> Date
    private var sessionID: UUID?
    private var contexts: [UUID: AuthorizedContentContext] = [:]
    private var catalogs: [UUID: AuthorizedCatalogContext] = [:]

    public init(vaultID: VaultID, ownerID: PrincipalID,
                now: @escaping @Sendable () -> Date = { Date() }) {
        self.vaultID = vaultID
        self.ownerID = ownerID
        self.now = now
    }

    /// Only a trusted authenticated owner service may call this. Identity alone
    /// is not authentication. Opening a session invalidates every prior context.
    public mutating func beginOwnerSession(principalID: PrincipalID) throws {
        guard principalID == ownerID else { throw AccessFailure.permissionDenied }
        contexts.removeAll()
        catalogs.removeAll()
        sessionID = UUID()
    }

    /// Invalidates issued and in-flight contexts; consumers must recheck at commit.
    public mutating func invalidateSession() {
        sessionID = nil
        contexts.removeAll()
        catalogs.removeAll()
    }

    public mutating func authorize(principalID: PrincipalID, request: ContentAccessRequest,
                          expiresAt: Date) throws -> AuthorizedContentContext {
        guard let sessionID else { throw AccessFailure.locked }
        guard principalID == ownerID, request.vaultID == vaultID else {
            throw AccessFailure.permissionDenied
        }
        let instant = now()
        // Bound process-local authority to five minutes, including owner contexts.
        guard expiresAt > instant, expiresAt <= instant.addingTimeInterval(300) else {
            throw AccessFailure.invalidInput
        }
        contexts = contexts.filter { $0.value.expiresAt > instant }
        guard contexts.count + catalogs.count < 1024 else { throw AccessFailure.permissionDenied }
        let context = AuthorizedContentContext(token: UUID(), principalID: principalID,
            request: request, sessionID: sessionID, expiresAt: expiresAt)
        contexts[context.token] = context
        return context
    }

    /// Recheck immediately before reading, submitting inference and committing.
    /// Repository adapters must additionally prove requested records belong to
    /// the vault; caller-supplied IDs alone do not establish that membership.
    public mutating func validate(_ context: AuthorizedContentContext,
                         for request: ContentAccessRequest) throws {
        guard let sessionID else { throw AccessFailure.locked }
        guard context.sessionID == sessionID,
              let issued = contexts[context.token],
              issued.principalID == ownerID,
              issued.request.vaultID == vaultID else {
            throw AccessFailure.permissionDenied
        }
        guard issued.expiresAt > now() else {
            contexts.removeValue(forKey: context.token)
            throw AccessFailure.grantExpired
        }
        let scope = issued.request
        guard request.vaultID == scope.vaultID,
              request.operation == scope.operation, request.purpose == scope.purpose,
              request.records.isSubset(of: scope.records),
              request.fields.isSubset(of: scope.fields) else {
            throw AccessFailure.permissionDenied
        }
    }

    public mutating func authorizeCatalog(principalID: PrincipalID, pageLimit: Int,
                                         expiresAt: Date) throws -> AuthorizedCatalogContext {
        guard let sessionID else { throw AccessFailure.locked }
        guard principalID == ownerID else { throw AccessFailure.permissionDenied }
        let instant = now()
        guard (1...100).contains(pageLimit), expiresAt > instant,
              expiresAt <= instant.addingTimeInterval(300) else { throw AccessFailure.invalidInput }
        catalogs = catalogs.filter { $0.value.expiresAt > instant }
        contexts = contexts.filter { $0.value.expiresAt > instant }
        guard contexts.count + catalogs.count < 1024 else { throw AccessFailure.permissionDenied }
        let context = AuthorizedCatalogContext(token: UUID(), vaultID: vaultID, principalID: ownerID,
            sessionID: sessionID, expiresAt: expiresAt, pageLimit: pageLimit)
        catalogs[context.token] = context
        return context
    }
    public mutating func validateCatalog(_ context: AuthorizedCatalogContext) throws {
        guard let sessionID else { throw AccessFailure.locked }
        guard let issued = catalogs[context.token], issued.sessionID == sessionID,
              issued.vaultID == vaultID, issued.principalID == ownerID else { throw AccessFailure.permissionDenied }
        guard issued.expiresAt > now() else {
            catalogs.removeValue(forKey: context.token)
            throw AccessFailure.grantExpired
        }
    }
    public mutating func revokeCatalog(_ context: AuthorizedCatalogContext) { catalogs.removeValue(forKey: context.token) }

    public mutating func revoke(_ context: AuthorizedContentContext) {
        contexts.removeValue(forKey: context.token)
    }
}

/// Actor facade for standalone policy clients; storage services can instead own
/// OwnerPolicyState on the same actor as a synchronous commit boundary.
public actor OwnerVaultPolicy {
    private var state: OwnerPolicyState
    public init(vaultID: VaultID, ownerID: PrincipalID,
                now: @escaping @Sendable () -> Date = { Date() }) {
        state = OwnerPolicyState(vaultID: vaultID, ownerID: ownerID, now: now)
    }
    public func beginOwnerSession(principalID: PrincipalID) throws {
        try state.beginOwnerSession(principalID: principalID)
    }
    public func invalidateSession() { state.invalidateSession() }
    public func authorize(principalID: PrincipalID, request: ContentAccessRequest,
                          expiresAt: Date) throws -> AuthorizedContentContext {
        try state.authorize(principalID: principalID, request: request, expiresAt: expiresAt)
    }
    public func validate(_ context: AuthorizedContentContext, for request: ContentAccessRequest) throws {
        try state.validate(context, for: request)
    }
    public func revoke(_ context: AuthorizedContentContext) { state.revoke(context) }
}
