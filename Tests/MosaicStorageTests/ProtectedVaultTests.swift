import Foundation
import Testing
import MosaicDomain
import MosaicPolicy
import MosaicStorage

@Test func scopedStorageDeniesReplayAndLockPreventsStaleCommits() async throws {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/storage-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    let owner = PrincipalID(UUID()), vaultID = VaultID(UUID()), record = ContentRecordID(UUID())
    let instant = Date(timeIntervalSince1970: 1000)
    let key = Data(repeating: 0x48, count: 32)
    let vault = try ProtectedVault(url: directory.appendingPathComponent("vault.sqlite"), key: key,
        vaultID: vaultID, authenticatedOwner: owner, create: true, now: { instant })
    func request(_ operation: ContentOperation, _ purpose: AccessPurpose,
                 _ fields: Set<ContentField>) throws -> ContentAccessRequest {
        try .init(vaultID: vaultID, operation: operation, purpose: purpose, records: [record], fields: fields)
    }
    let intake = try await vault.authorize(principalID: owner,
        request: request(.capture, .ownerCapture, [.source]), expiresAt: instant.addingTimeInterval(60))
    let received = try await vault.receive(source: Data("SYNTHETIC SCOPED SOURCE".utf8), proposedID: record, context: intake)
    #expect(received == record)
    await #expect(throws: AccessFailure.permissionDenied) {
        try await vault.source(id: record, context: intake)
    }
    let read = try await vault.authorize(principalID: owner,
        request: request(.read, .ownerReview, [.source]), expiresAt: instant.addingTimeInterval(60))
    #expect(try await vault.source(id: record, context: read) == Data("SYNTHETIC SCOPED SOURCE".utf8))
    let process = try await vault.authorize(principalID: owner,
        request: request(.process, .ownerProcessing, [.observation]), expiresAt: instant.addingTimeInterval(60))
    try await vault.saveObservation(id: record, text: "SYNTHETIC OBSERVATION", context: process)
    let write = try await vault.authorize(principalID: owner,
        request: request(.correct, .ownerReview, [.correction]), expiresAt: instant.addingTimeInterval(60))
    await vault.lock()
    await #expect(throws: AccessFailure.locked) {
        try await vault.approve(id: record, text: "SYNTHETIC STALE COMMIT", expectedRevision: 2, context: write)
    }
    await #expect(throws: AccessFailure.locked) {
        try await vault.source(id: record, context: read)
    }
    let reopened = try EncryptedVault(url: directory.appendingPathComponent("vault.sqlite"), key: key, create: false)
    #expect(try await reopened.capture(id: record.rawValue).acceptedText == nil)
    await reopened.lock()
    #expect(throws: VaultStorageFailure.invalidInput) {
        _ = try ProtectedVault(url: directory.appendingPathComponent("vault.sqlite"), key: key,
            vaultID: VaultID(UUID()), authenticatedOwner: owner, create: false)
    }
}

@Test func scopedSearchAndDuplicateReceiptCannotRevealOtherRecords() async throws {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/storage-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    let owner = PrincipalID(UUID()), vaultID = VaultID(UUID())
    let first = ContentRecordID(UUID()), second = ContentRecordID(UUID()), proposed = ContentRecordID(UUID())
    let instant = Date(timeIntervalSince1970: 1000)
    let vault = try ProtectedVault(url: directory.appendingPathComponent("vault.sqlite"), key: Data(repeating: 0x49, count: 32),
        vaultID: vaultID, authenticatedOwner: owner, create: true, now: { instant })
    func grant(_ operation: ContentOperation, _ purpose: AccessPurpose,
               _ ids: Set<ContentRecordID>, _ fields: Set<ContentField>) async throws -> AuthorizedContentContext {
        let request = try ContentAccessRequest(vaultID: vaultID, operation: operation, purpose: purpose, records: ids, fields: fields)
        return try await vault.authorize(principalID: owner, request: request, expiresAt: instant.addingTimeInterval(60))
    }
    for (id, source) in [(first, "SYNTHETIC FIRST"), (second, "SYNTHETIC SECOND")] {
        let intake = try await grant(.capture, .ownerCapture, [id], [.source])
        _ = try await vault.receive(source: Data(source.utf8), proposedID: id, context: intake)
        let process = try await grant(.process, .ownerProcessing, [id], [.observation])
        try await vault.saveObservation(id: id, text: "SYNTHETIC observation", context: process)
        let correction = try await grant(.correct, .ownerReview, [id], [.correction])
        try await vault.approve(id: id, text: "SYNTHETIC matching term", expectedRevision: 2, context: correction)
    }
    let search = try await grant(.search, .ownerSearch, [first], [.correction])
    #expect(try await vault.search("matching", context: search) == [first])
    let narrowCapture = try await grant(.capture, .ownerCapture, [proposed], [.source])
    await #expect(throws: VaultStorageFailure.recordUnavailable) {
        try await vault.receive(source: Data("SYNTHETIC SECOND".utf8), proposedID: proposed, context: narrowCapture)
    }
    let broadCapture = try await grant(.capture, .ownerCapture, [proposed, second], [.source])
    #expect(try await vault.receive(source: Data("SYNTHETIC SECOND".utf8), proposedID: proposed, context: broadCapture) == second)
    await vault.lock()
}

@Test func backupRequiresExplicitCompleteScopeBeforeWritingAnyDestination() async throws {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/storage-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    let owner = PrincipalID(UUID()), vaultID = VaultID(UUID()), first = ContentRecordID(UUID()), second = ContentRecordID(UUID())
    let instant = Date(timeIntervalSince1970: 1000)
    let vault = try ProtectedVault(url: directory.appendingPathComponent("vault.sqlite"), key: Data(repeating: 0x7A, count: 32),
        vaultID: vaultID, authenticatedOwner: owner, create: true, now: { instant })
    for (id, text) in [(first, "SYNTHETIC first"), (second, "SYNTHETIC second")] {
        let request = try ContentAccessRequest(vaultID: vaultID, operation: .capture, purpose: .ownerCapture, records: [id], fields: [.source])
        let context = try await vault.authorize(principalID: owner, request: request, expiresAt: instant.addingTimeInterval(60))
        _ = try await vault.receive(source: Data(text.utf8), proposedID: id, context: context)
    }
    let request = try ContentAccessRequest(vaultID: vaultID, operation: .backup, purpose: .ownerBackup,
        records: [first], fields: [.source, .observation, .correction, .processingState])
    let context = try await vault.authorize(principalID: owner, request: request, expiresAt: instant.addingTimeInterval(60))
    let destination = directory.appendingPathComponent("denied.sqlite")
    await #expect(throws: AccessFailure.permissionDenied) {
        try await vault.snapshot(to: destination, recoveryKey: Data(repeating: 0x7B, count: 32), context: context)
    }
    #expect(!FileManager.default.fileExists(atPath: destination.path))
    await vault.lock()
}
