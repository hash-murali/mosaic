import Foundation
import Testing
import MosaicDomain
import MosaicPolicy

private final class TestClock: @unchecked Sendable {
    private let lock = NSLock()
    private var value = Date(timeIntervalSince1970: 1_000)
    func read() -> Date { lock.withLock { value } }
    func advance(_ seconds: TimeInterval) { lock.withLock { value.addTimeInterval(seconds) } }
}

private struct Fixture {
    let vault = VaultID(UUID())
    let owner = PrincipalID(UUID())
    let first = ContentRecordID(UUID())
    let second = ContentRecordID(UUID())
    let clock = TestClock()
    func request(vault: VaultID? = nil, records: Set<ContentRecordID>? = nil,
                 fields: Set<ContentField> = [.observation, .correction],
                 operation: ContentOperation = .read,
                 purpose: AccessPurpose = .ownerReview) throws -> ContentAccessRequest {
        try .init(vaultID: vault ?? self.vault, operation: operation, purpose: purpose,
                  records: records ?? [first, second], fields: fields)
    }
    func policy() -> OwnerVaultPolicy {
        OwnerVaultPolicy(vaultID: vault, ownerID: owner, now: { clock.read() })
    }
}

@Test func accessDefaultsToLockedAndRejectsWrongOwnerOrVault() async throws {
    let f = Fixture(), policy = f.policy(), request = try f.request()
    await #expect(throws: AccessFailure.locked) {
        try await policy.authorize(principalID: f.owner, request: request,
                                   expiresAt: f.clock.read().addingTimeInterval(60))
    }
    await #expect(throws: AccessFailure.permissionDenied) {
        try await policy.beginOwnerSession(principalID: PrincipalID(UUID()))
    }
    try await policy.beginOwnerSession(principalID: f.owner)
    await #expect(throws: AccessFailure.permissionDenied) {
        try await policy.authorize(principalID: PrincipalID(UUID()), request: request,
                                   expiresAt: f.clock.read().addingTimeInterval(60))
    }
    await #expect(throws: AccessFailure.permissionDenied) {
        try await policy.authorize(principalID: f.owner,
                                   request: f.request(vault: VaultID(UUID())),
                                   expiresAt: f.clock.read().addingTimeInterval(60))
    }
}

@Test func contextAllowsNarrowingButNeverScopeExpansion() async throws {
    let f = Fixture(), policy = f.policy(), request = try f.request()
    try await policy.beginOwnerSession(principalID: f.owner)
    let context = try await policy.authorize(principalID: f.owner, request: request,
        expiresAt: f.clock.read().addingTimeInterval(60))
    try await policy.validate(context, for: f.request(records: [f.first], fields: [.observation]))
    let forbidden = [
        try f.request(records: [ContentRecordID(UUID())]),
        try f.request(fields: [.source]),
        try f.request(vault: VaultID(UUID())),
        try f.request(operation: .correct),
        try f.request(operation: .search, purpose: .ownerSearch)
    ]
    for request in forbidden {
        await #expect(throws: AccessFailure.permissionDenied) {
            try await policy.validate(context, for: request)
        }
    }
}

@Test func expiryRevocationAndSessionReplacementInvalidateInFlightContexts() async throws {
    let f = Fixture(), policy = f.policy(), request = try f.request()
    try await policy.beginOwnerSession(principalID: f.owner)
    let context = try await policy.authorize(principalID: f.owner, request: request,
        expiresAt: f.clock.read().addingTimeInterval(60))
    f.clock.advance(60)
    await #expect(throws: AccessFailure.grantExpired) {
        try await policy.validate(context, for: request)
    }
    let revoked = try await policy.authorize(principalID: f.owner, request: request,
        expiresAt: f.clock.read().addingTimeInterval(60))
    await policy.revoke(revoked)
    await #expect(throws: AccessFailure.permissionDenied) {
        try await policy.validate(revoked, for: request)
    }
    let stale = try await policy.authorize(principalID: f.owner, request: request,
        expiresAt: f.clock.read().addingTimeInterval(60))
    await policy.invalidateSession()
    await #expect(throws: AccessFailure.locked) {
        try await policy.validate(stale, for: request)
    }
    try await policy.beginOwnerSession(principalID: f.owner)
    await #expect(throws: AccessFailure.permissionDenied) {
        try await policy.validate(stale, for: request)
    }
}

@Test func aContextFromAnotherPolicyInstanceHasNoAuthority() async throws {
    let f = Fixture(), firstPolicy = f.policy(), secondPolicy = f.policy()
    try await firstPolicy.beginOwnerSession(principalID: f.owner)
    try await secondPolicy.beginOwnerSession(principalID: f.owner)
    let request = try f.request()
    let context = try await firstPolicy.authorize(principalID: f.owner, request: request,
        expiresAt: f.clock.read().addingTimeInterval(60))
    await #expect(throws: AccessFailure.permissionDenied) {
        try await secondPolicy.validate(context, for: request)
    }
}

@Test func requestsAndAuthorityRequireExplicitValidBounds() async throws {
    let f = Fixture(), policy = f.policy()
    #expect(throws: AccessFailure.invalidInput) { try f.request(records: []) }
    #expect(throws: AccessFailure.invalidInput) { try f.request(fields: []) }
    #expect(throws: AccessFailure.invalidInput) { try f.request(purpose: .ownerSearch) }
    try await policy.beginOwnerSession(principalID: f.owner)
    let request = try f.request()
    for seconds: TimeInterval in [-1, 0, 301] {
        await #expect(throws: AccessFailure.invalidInput) {
            try await policy.authorize(principalID: f.owner, request: request,
                expiresAt: f.clock.read().addingTimeInterval(seconds))
        }
    }
}

@Test func boundedCatalogAuthorityRejectsOtherInstancesAndLockReplay() throws {
    let owner = PrincipalID(UUID()), vault = VaultID(UUID()), instant = Date(timeIntervalSince1970: 1000)
    var state = OwnerPolicyState(vaultID: vault, ownerID: owner, now: { instant })
    #expect(throws: AccessFailure.locked) { try state.authorizeCatalog(principalID: owner, pageLimit: 10, expiresAt: instant.addingTimeInterval(60)) }
    try state.beginOwnerSession(principalID: owner)
    #expect(throws: AccessFailure.permissionDenied) { try state.authorizeCatalog(principalID: PrincipalID(UUID()), pageLimit: 10, expiresAt: instant.addingTimeInterval(60)) }
    #expect(throws: AccessFailure.invalidInput) { try state.authorizeCatalog(principalID: owner, pageLimit: 101, expiresAt: instant.addingTimeInterval(60)) }
    let context = try state.authorizeCatalog(principalID: owner, pageLimit: 10, expiresAt: instant.addingTimeInterval(60))
    try state.validateCatalog(context)
    var other = OwnerPolicyState(vaultID: vault, ownerID: owner, now: { instant })
    try other.beginOwnerSession(principalID: owner)
    #expect(throws: AccessFailure.permissionDenied) { try other.validateCatalog(context) }
    state.revokeCatalog(context)
    #expect(throws: AccessFailure.permissionDenied) { try state.validateCatalog(context) }
    let replacement = try state.authorizeCatalog(principalID: owner, pageLimit: 10, expiresAt: instant.addingTimeInterval(60))
    state.invalidateSession()
    #expect(throws: AccessFailure.locked) { try state.validateCatalog(replacement) }
    try state.beginOwnerSession(principalID: owner)
    #expect(throws: AccessFailure.permissionDenied) { try state.validateCatalog(replacement) }
}
