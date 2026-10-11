import Foundation
import Testing
import MosaicStorage

private func fixtureURL() throws -> URL {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
        .deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/storage-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    return directory.appendingPathComponent("fixture.sqlite")
}

@Test func encryptedReceiptSurvivesReopenAndWrongKeyFails() async throws {
    let url = try fixtureURL()
    let key = Data(repeating: 0x41, count: 32) // synthetic key, never a real credential
    let source = Data("SYNTHETIC SOURCE MARKER NEVER PLAINTEXT 428913".utf8)
    let vault = try EncryptedVault(url: url, key: key, create: true)
    let id = try await vault.receive(source: source)
    let repeated = try await vault.receive(source: source)
    #expect(repeated == id)
    #expect(try await vault.pendingJobs() == [id])
    for artifact in try FileManager.default.contentsOfDirectory(at: url.deletingLastPathComponent(), includingPropertiesForKeys: nil) {
        let bytes = try Data(contentsOf: artifact)
        #expect(bytes.range(of: source) == nil)
        #expect(!bytes.starts(with: Data("SQLite format 3".utf8)))
    }
    await vault.lock()
    await #expect(throws: VaultStorageFailure.locked) { try await vault.source(id: id) }
    #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        _ = try EncryptedVault(url: url, key: Data(repeating: 0x42, count: 32), create: false)
    }
    let reopened = try EncryptedVault(url: url, key: key, create: false)
    #expect(try await reopened.source(id: id) == source)
    #expect(try await reopened.pendingJobs() == [id])
    await reopened.lock()
}

@Test func encryptedFTSCorrectionRevisionAndDeletionAreAtomic() async throws {
    let vault = try EncryptedVault(url: fixtureURL(), key: Data(repeating: 0x43, count: 32), create: true)
    let id = try await vault.receive(source: Data("SYNTHETIC PIXELS".utf8))
    try await vault.saveObservation(id: id, text: "SYNTHETIC TRAIN 1900")
    #expect(try await vault.search("train").isEmpty)
    try await vault.approve(id: id, text: "SYNTHETIC TRAIN 2000", expectedRevision: 2)
    #expect(try await vault.search("train 2000") == [id])
    #expect(try await vault.search("1900").isEmpty)
    #expect(try await vault.capture(id: id).observation == "SYNTHETIC TRAIN 1900")
    await #expect(throws: VaultStorageFailure.staleRevision) {
        try await vault.approve(id: id, text: "SYNTHETIC BAD UPDATE", expectedRevision: 2)
    }
    await #expect(throws: VaultStorageFailure.invalidInput) {
        try await vault.approve(id: id, text: " \n", expectedRevision: 3)
    }
    #expect(try await vault.search("2000") == [id])
    try await vault.delete(id: id, expectedRevision: 3)
    #expect(try await vault.search("2000").isEmpty)
    await #expect(throws: VaultStorageFailure.recordUnavailable) { try await vault.source(id: id) }
    await vault.lock()
}

@Test func independentEncryptedSnapshotRestoresAndNeverOverwrites() async throws {
    let url = try fixtureURL()
    let sourceKey = Data(repeating: 0x44, count: 32)
    let recoveryKey = Data(repeating: 0x45, count: 32)
    let vault = try EncryptedVault(url: url, key: sourceKey, create: true)
    let source = Data("SYNTHETIC RESTORE SOURCE 78193".utf8)
    let id = try await vault.receive(source: source)
    try await vault.saveObservation(id: id, text: "SYNTHETIC RESTORE ORIGINAL")
    try await vault.approve(id: id, text: "SYNTHETIC RESTORE CORRECTION", expectedRevision: 2)
    let snapshot = url.deletingLastPathComponent().appendingPathComponent("snapshot.sqlite")
    try await vault.snapshot(to: snapshot, recoveryKey: recoveryKey)
    await vault.lock()
    #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        _ = try EncryptedVault(url: snapshot, key: sourceKey, create: false)
    }
    let restored = try EncryptedVault(url: snapshot, key: recoveryKey, create: false)
    #expect(try await restored.source(id: id) == source)
    #expect(try await restored.search("restore correction") == [id])
    #expect(try await restored.capture(id: id).observation == "SYNTHETIC RESTORE ORIGINAL")
    let before = try Data(contentsOf: snapshot)
    await #expect(throws: VaultStorageFailure.invalidInput) {
        try await restored.snapshot(to: snapshot, recoveryKey: recoveryKey)
    }
    #expect(try Data(contentsOf: snapshot) == before)
    await restored.lock()
}

@Test func encryptedStoreRejectsTamperingAndMissingVolumeWithoutFallback() async throws {
    let url = try fixtureURL()
    let key = Data(repeating: 0x46, count: 32)
    let vault = try EncryptedVault(url: url, key: key, create: true)
    _ = try await vault.receive(source: Data("SYNTHETIC AUTHENTICATED SOURCE".utf8))
    await vault.lock()
    var bytes = try Data(contentsOf: url)
    bytes[bytes.count / 2] ^= 0x01
    try bytes.write(to: url) // only this test's generated synthetic artifact
    #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        _ = try EncryptedVault(url: url, key: key, create: false)
    }
    let absent = url.deletingLastPathComponent().appendingPathComponent("missing-volume/no-vault.sqlite")
    #expect(throws: VaultStorageFailure.storageUnavailable) {
        _ = try EncryptedVault(url: absent, key: key, create: false)
    }
    #expect(!FileManager.default.fileExists(atPath: absent.path))
}

@Test func untrustedObservationIsBoundAsDataIncludingNullAndUnicode() async throws {
    let vault = try EncryptedVault(url: fixtureURL(), key: Data(repeating: 0x47, count: 32), create: true)
    let id = try await vault.receive(source: Data("SYNTHETIC TEXT INPUT".utf8))
    let text = "SYNTHETIC café\0 DROP TABLE captures; --"
    try await vault.saveObservation(id: id, text: text)
    #expect(try await vault.capture(id: id).observation == text)
    #expect(try await vault.source(id: id) == Data("SYNTHETIC TEXT INPUT".utf8))
    await vault.lock()
}

@Test func storagePathDisappearanceClosesHandleWithoutFallbackAndSQLiteFullKeepsPriorReceipt() async throws {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/fault-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    let url = directory.appendingPathComponent("vault.sqlite"), key = Data(repeating: 0x77, count: 32)
    let vault = try EncryptedVault(url: url, key: key, create: true, maximumPages: 32)
    let source = Data("SYNTHETIC durable prior receipt".utf8)
    let id = try await vault.receive(source: source)
    await #expect(throws: VaultStorageFailure.storageUnavailable) {
        try await vault.receive(source: Data(repeating: 0x78, count: 2 * 1024 * 1024))
    }
    #expect(try await vault.pendingJobs() == [id])
    #expect(try await vault.source(id: id) == source)
    await vault.lock()
    let reopened = try EncryptedVault(url: url, key: key, create: false)
    #expect(try await reopened.source(id: id) == source)
    let moved = directory.deletingLastPathComponent().appendingPathComponent("relocated-\(UUID().uuidString)")
    try FileManager.default.moveItem(at: directory, to: moved) // generated fixture only; preserve for recovery
    await #expect(throws: VaultStorageFailure.storageUnavailable) { try await reopened.source(id: id) }
    await #expect(throws: VaultStorageFailure.locked) { try await reopened.pendingJobs() }
    #expect(!FileManager.default.fileExists(atPath: url.path))
    let relocated = try EncryptedVault(url: moved.appendingPathComponent("vault.sqlite"), key: key, create: false)
    #expect(try await relocated.source(id: id) == source)
    await relocated.lock()
}
