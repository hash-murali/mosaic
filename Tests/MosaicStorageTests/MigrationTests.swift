import Foundation
import Testing
import SQLCipher
import CryptoKit
import MosaicStorage

private func legacyFixture(version: Int) throws -> (URL, Data, UUID) {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/migration-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    let url = directory.appendingPathComponent("legacy.sqlite"), key = Data(repeating: 0x73, count: 32), id = UUID()
    var db: OpaquePointer?
    guard sqlite3_open(url.path, &db) == SQLITE_OK, let db else { throw VaultStorageFailure.storageUnavailable }
    defer { sqlite3_close(db) }
    guard key.withUnsafeBytes({ sqlite3_key(db, $0.baseAddress, 32) }) == SQLITE_OK else { throw VaultStorageFailure.invalidInput }
    // Fixed generated content only, no user-supplied SQL.
    let source = Data("SYNTHETIC legacy receipt".utf8)
    let hex = source.map { String(format: "%02x", $0) }.joined()
    let hash = SHA256.hash(data: source).map { String(format: "%02x", $0) }.joined()
    let sql = """
    CREATE TABLE captures(id TEXT PRIMARY KEY, hash TEXT NOT NULL UNIQUE, source BLOB NOT NULL,
      observation TEXT NOT NULL DEFAULT '',accepted TEXT,revision INTEGER NOT NULL DEFAULT 1,stage TEXT NOT NULL DEFAULT 'received');
    CREATE VIRTUAL TABLE search_index USING fts5(id UNINDEXED,body);
    INSERT INTO captures(id,hash,source) VALUES('\(id.uuidString)','\(hash)',X'\(hex)');
    PRAGMA user_version=\(version);
    """
    guard sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK else { throw VaultStorageFailure.invalidInput }
    return (url, key, id)
}

@Test func priorSchemaMigratesWithEncryptedRollbackSnapshotAndFutureSchemaRejects() async throws {
    let (url, key, legacyID) = try legacyFixture(version: 1)
    let vault = try EncryptedVault(url: url, key: key, create: false)
    #expect(try await vault.source(id: legacyID) == Data("SYNTHETIC legacy receipt".utf8))
    #expect(try await vault.capture(id: legacyID).needsProcessing == true)
    let id = try await vault.receive(source: Data("SYNTHETIC migration source".utf8))
    #expect(try await vault.capture(id: id).processingAttempts == 0)
    #expect(try await vault.capture(id: id).needsProcessing == true)
    await vault.lock()
    let backups = try FileManager.default.contentsOfDirectory(at: url.deletingLastPathComponent(), includingPropertiesForKeys: nil)
        .filter { $0.lastPathComponent.hasPrefix("migration-v1-") }
    #expect(backups.count == 1)
    #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        _ = try EncryptedVault(url: backups[0], key: Data(repeating: 0x74, count: 32), create: false)
    }
    let rollback = try EncryptedVault(url: backups[0], key: key, create: false, readOnly: true)
    #expect(try await rollback.source(id: legacyID) == Data("SYNTHETIC legacy receipt".utf8))
    await rollback.lock()
    let (future, futureKey, _) = try legacyFixture(version: 99)
    #expect(throws: VaultStorageFailure.incompatibleVersion) {
        _ = try EncryptedVault(url: future, key: futureKey, create: false)
    }
}
