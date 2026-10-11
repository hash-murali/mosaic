import Foundation
import CryptoKit
import SQLCipher

public enum VaultStorageFailure: Error, Equatable, Sendable {
    case locked, invalidInput, storageUnavailable, invalidKeyOrCorruptStore
    case incompatibleVersion, staleRevision, recordUnavailable
}

public struct StoredCapture: Equatable, Sendable {
    public let id: UUID
    public let sourceHash: String
    public let observation: String
    public let acceptedText: String?
    public let revision: Int
    public let needsProcessing: Bool
    public let processingAttempts: Int
    public let retryRequired: Bool
}

/// SQLCipher integration spike. Sources live as encrypted database blobs, so
/// metadata/source receipt commits in one transaction. No plaintext files.
/// Not yet wired to authenticated application services or production data.
final class EncryptedDatabase {
    private final class Handle: @unchecked Sendable {
        let pointer: OpaquePointer
        init(_ pointer: OpaquePointer) { self.pointer = pointer }
        deinit { sqlite3_close_v2(pointer) }
    }
    private var handle: Handle?
    private let location: URL
    private var fileIdentity: FileIdentity?
    private struct FileIdentity: Equatable {
        let file: NSObject
        let volume: NSObject
    }
    private static func identityOfFile(_ url: URL) throws -> FileIdentity {
        var fresh = url
        fresh.removeAllCachedResourceValues()
        let values = try fresh.resourceValues(forKeys: [.isRegularFileKey, .fileResourceIdentifierKey, .volumeIdentifierKey])
        guard values.isRegularFile == true,
              let file = values.fileResourceIdentifier as? NSObject,
              let volume = values.volumeIdentifier as? NSObject else { throw VaultStorageFailure.storageUnavailable }
        return FileIdentity(file: file, volume: volume)
    }
    private static let transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    public init(url: URL, key: Data, create: Bool, readOnly: Bool = false, maximumPages: Int = 786_432) throws {
        location = url
        guard (16...786_432).contains(maximumPages), url.standardizedFileURL == url.resolvingSymlinksInPath() else { throw VaultStorageFailure.invalidInput }
        guard url.isFileURL, key.count == 32 else { throw VaultStorageFailure.invalidInput }
        if !create && !FileManager.default.fileExists(atPath: url.path) {
            throw VaultStorageFailure.storageUnavailable
        }
        if FileManager.default.fileExists(atPath: url.path) {
            let size = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
            guard size <= 3 * 1024 * 1024 * 1024 else { throw VaultStorageFailure.invalidInput }
        }
        guard !readOnly || !create else { throw VaultStorageFailure.invalidInput }
        var connection: OpaquePointer?
        let flags = (readOnly ? SQLITE_OPEN_READONLY : SQLITE_OPEN_READWRITE) | SQLITE_OPEN_FULLMUTEX | (create ? SQLITE_OPEN_CREATE : 0)
        guard sqlite3_open_v2(url.path, &connection, flags, nil) == SQLITE_OK, let connection else {
            if let connection { sqlite3_close_v2(connection) }
            throw VaultStorageFailure.storageUnavailable
        }
        let owned = Handle(connection)
        let keyed = key.withUnsafeBytes { sqlite3_key(connection, $0.baseAddress, Int32(key.count)) }
        guard keyed == SQLITE_OK else { throw VaultStorageFailure.invalidKeyOrCorruptStore }
        _ = owned // retain through all initialization checks
        try Self.execute(connection, "PRAGMA cipher_memory_security=ON; PRAGMA temp_store=MEMORY; PRAGMA foreign_keys=ON;")
        guard try Self.scalar(connection, "PRAGMA cipher_version;").hasPrefix("4.") else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        let version = Int(try Self.scalar(connection, "PRAGMA user_version;")) ?? -1
        guard (0...2).contains(version) else { throw VaultStorageFailure.incompatibleVersion }
        if version == 0 {
            guard create else { throw VaultStorageFailure.incompatibleVersion }
            try Self.execute(connection, """
            BEGIN IMMEDIATE;
            CREATE TABLE captures(id TEXT PRIMARY KEY, hash TEXT NOT NULL UNIQUE,
                source BLOB NOT NULL, observation TEXT NOT NULL DEFAULT '', accepted TEXT,
                revision INTEGER NOT NULL DEFAULT 1, stage TEXT NOT NULL DEFAULT 'received',
                attempts INTEGER NOT NULL DEFAULT 0, failure TEXT);
            CREATE VIRTUAL TABLE search_index USING fts5(id UNINDEXED, body);
            PRAGMA user_version=2;
            COMMIT;
            """)
        }
        guard try Self.scalar(connection, "PRAGMA integrity_check;") == "ok" else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        guard try Self.rows(connection, "PRAGMA cipher_integrity_check;").isEmpty else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        self.handle = owned
        fileIdentity = try Self.identityOfFile(url)
        if version == 1 && !readOnly {
            // Preserve a verified encrypted prior-schema snapshot before mutation.
            let backup = url.deletingLastPathComponent().appendingPathComponent("migration-v1-\(UUID().uuidString).sqlite")
            try snapshot(to: backup, recoveryKey: key)
            try Self.execute(connection, """
            BEGIN IMMEDIATE;
            ALTER TABLE captures ADD COLUMN attempts INTEGER NOT NULL DEFAULT 0;
            ALTER TABLE captures ADD COLUMN failure TEXT;
            PRAGMA user_version=2;
            COMMIT;
            """)
        }
        if !readOnly {
            try Self.execute(connection, "PRAGMA journal_mode=WAL; PRAGMA synchronous=FULL;")
            guard let pageLimit = Int(try Self.scalar(connection, "PRAGMA max_page_count=\(maximumPages);")),
                  pageLimit <= maximumPages else { throw VaultStorageFailure.invalidInput }
        }
    }

    public func lock() { handle = nil }

    /// SQLCipher-to-SQLCipher consistent backup with an independent 32-byte key.
    /// Never replaces an existing destination; stages in the same selected parent.
    /// Still requires owner credential UX and an independent-device restore drill.
    public func snapshot(to destination: URL, recoveryKey: Data, destinationVaultID: UUID? = nil) throws {
        guard destination.isFileURL, recoveryKey.count == 32,
              !FileManager.default.fileExists(atPath: destination.path) else {
            throw VaultStorageFailure.invalidInput
        }
        let db = try connection()
        let staging = destination.deletingLastPathComponent()
            .appendingPathComponent(".mosaic-snapshot-\(UUID().uuidString)", isDirectory: true)
        try FileManager.default.createDirectory(at: staging, withIntermediateDirectories: false)
        defer { try? FileManager.default.removeItem(at: staging) } // only this operation's generated staging
        let candidate = staging.appendingPathComponent("snapshot.sqlite")
        var target: OpaquePointer?
        guard sqlite3_open_v2(candidate.path, &target, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, nil) == SQLITE_OK,
              let target else { throw VaultStorageFailure.storageUnavailable }
        var targetClosed = false
        defer { if !targetClosed { sqlite3_close_v2(target) } }
        guard recoveryKey.withUnsafeBytes({ sqlite3_key(target, $0.baseAddress, Int32(recoveryKey.count)) }) == SQLITE_OK else {
            throw VaultStorageFailure.invalidInput
        }
        try Self.execute(target, "PRAGMA temp_store=MEMORY; PRAGMA cipher_memory_security=ON;")
        guard let backup = sqlite3_backup_init(target, "main", db, "main") else {
            throw VaultStorageFailure.storageUnavailable
        }
        let result = sqlite3_backup_step(backup, -1)
        let finished = sqlite3_backup_finish(backup)
        guard result == SQLITE_DONE, finished == SQLITE_OK,
              try Self.scalar(target, "PRAGMA integrity_check;") == "ok" else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        // Rebind only the staged, independently encrypted restoration copy.
        // The original source/backup and owner identity remain unchanged.
        if let destinationVaultID {
            try Self.run(target, "UPDATE vault_identity SET vault=? WHERE singleton=1;", strings: [destinationVaultID.uuidString])
            guard sqlite3_changes(target) == 1,
                  try Self.scalar(target, "PRAGMA integrity_check;") == "ok" else { throw VaultStorageFailure.invalidInput }
        }
        // A successful backup includes only committed source + metadata + FTS.
        guard sqlite3_close(target) == SQLITE_OK else { throw VaultStorageFailure.storageUnavailable }
        targetClosed = true
        try FileManager.default.moveItem(at: candidate, to: destination)
    }
    private func connection() throws -> OpaquePointer {
        guard let handle else { throw VaultStorageFailure.locked }
        guard let observed = try? Self.identityOfFile(location), observed == fileIdentity else {
            self.handle = nil
            throw VaultStorageFailure.storageUnavailable
        }
        return handle.pointer
    }

    /// Durable source receipt. Exact original-byte duplicates reuse identity.
    public func receive(source: Data, proposedID: UUID = UUID(), allowedExistingIDs: Set<UUID>? = nil) throws -> UUID {
        guard !source.isEmpty, source.count <= 25 * 1024 * 1024 else {
            throw VaultStorageFailure.invalidInput
        }
        let db = try connection()
        let hash = SHA256.hash(data: source).map { String(format: "%02x", $0) }.joined()
        if let existingText = try Self.rows(db, "SELECT id FROM captures WHERE hash=?;", strings: [hash]).first?.first,
           let existingID = UUID(uuidString: existingText) {
            if let allowedExistingIDs, !allowedExistingIDs.contains(existingID) {
                throw VaultStorageFailure.recordUnavailable
            }
            return existingID
        }
        let id = proposedID
        try Self.run(db, "INSERT OR IGNORE INTO captures(id,hash,source) VALUES(?,?,?);",
                     strings: [id.uuidString, hash], blob: source)
        let rows = try Self.rows(db, "SELECT id FROM captures WHERE hash=?;", strings: [hash])
        guard let text = rows.first?.first, let storedID = UUID(uuidString: text) else {
            throw VaultStorageFailure.storageUnavailable
        }
        return storedID
    }

    func catalog(after: UUID?, limit: Int) throws -> [UUID] {
        guard (1...100).contains(limit) else { throw VaultStorageFailure.invalidInput }
        return try Self.rows(connection(), "SELECT id FROM captures WHERE id>? ORDER BY id LIMIT ?;",
            strings: [after?.uuidString ?? "", String(limit)]).compactMap { UUID(uuidString: $0[0]) }
    }

    public func pendingJobs() throws -> [UUID] {
        try Self.rows(connection(), "SELECT id FROM captures WHERE stage='received' ORDER BY rowid;")
            .compactMap { UUID(uuidString: $0[0]) }
    }

    public func saveObservation(id: UUID, text: String) throws {
        guard text.utf8.count <= 1_000_000 else { throw VaultStorageFailure.invalidInput }
        let db = try connection()
        try Self.run(db, "UPDATE captures SET observation=?,stage='review_ready',failure=NULL,revision=revision+1 WHERE id=? AND stage='received';",
                     strings: [text, id.uuidString])
        guard sqlite3_changes(db) == 1 else { throw VaultStorageFailure.staleRevision }
    }

    func recordProcessingFailure(id: UUID) throws {
        let db = try connection()
        try Self.run(db, "UPDATE captures SET attempts=attempts+1,failure='ocr_failed' WHERE id=? AND stage='received' AND attempts<3;", strings: [id.uuidString])
        guard sqlite3_changes(db) == 1 else { throw VaultStorageFailure.staleRevision }
    }
    func retryProcessing(id: UUID) throws {
        let db = try connection()
        try Self.run(db, "UPDATE captures SET attempts=0,failure=NULL WHERE id=? AND stage='received';", strings: [id.uuidString])
        guard sqlite3_changes(db) == 1 else { throw VaultStorageFailure.staleRevision }
    }

    public func approve(id: UUID, text: String, expectedRevision: Int) throws {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              text.utf8.count <= 1_000_000 else { throw VaultStorageFailure.invalidInput }
        let db = try connection()
        try Self.execute(db, "BEGIN IMMEDIATE;")
        do {
            try Self.run(db, "UPDATE captures SET accepted=?,revision=revision+1 WHERE id=? AND revision=? AND stage='review_ready';",
                         strings: [text, id.uuidString, String(expectedRevision)])
            guard sqlite3_changes(db) == 1 else { throw VaultStorageFailure.staleRevision }
            try Self.run(db, "DELETE FROM search_index WHERE id=?;", strings: [id.uuidString])
            try Self.run(db, "INSERT INTO search_index(id,body) VALUES(?,?);", strings: [id.uuidString, text])
            try Self.execute(db, "COMMIT;")
        } catch { try? Self.execute(db, "ROLLBACK;"); throw error }
    }

    public func search(_ text: String, allowedIDs: Set<UUID>? = nil) throws -> [UUID] {
        let db = try connection()
        let terms = text.split(whereSeparator: { $0.isWhitespace })
        guard !terms.isEmpty, text.utf8.count <= 4096 else { return [] }
        let query = terms.map { "\"" + $0.replacingOccurrences(of: "\"", with: "\"\"") + "\"" }.joined(separator: " AND ")
        if let allowedIDs {
            guard !allowedIDs.isEmpty, allowedIDs.count <= 100 else { throw VaultStorageFailure.invalidInput }
            let ids = allowedIDs.map(\.uuidString).sorted()
            let placeholders = ids.map { _ in "?" }.joined(separator: ",")
            return try Self.rows(db, "SELECT id FROM search_index WHERE search_index MATCH ? AND id IN (\(placeholders)) LIMIT 100;",
                strings: [query] + ids).compactMap { UUID(uuidString: $0[0]) }
        }
        return try Self.rows(db, "SELECT id FROM search_index WHERE search_index MATCH ? LIMIT 100;", strings: [query])
            .compactMap { UUID(uuidString: $0[0]) }
    }

    func bindIdentity(vaultID: UUID, ownerID: UUID, create: Bool) throws {
        let db = try connection()
        if create {
            try Self.execute(db, "CREATE TABLE IF NOT EXISTS vault_identity(singleton INTEGER PRIMARY KEY CHECK(singleton=1), vault TEXT NOT NULL, owner TEXT NOT NULL);")
            try Self.run(db, "INSERT OR IGNORE INTO vault_identity(singleton,vault,owner) VALUES(1,?,?);",
                         strings: [vaultID.uuidString, ownerID.uuidString])
        }
        guard try Self.rows(db, "SELECT vault,owner FROM vault_identity WHERE singleton=1;").first == [vaultID.uuidString, ownerID.uuidString] else {
            throw VaultStorageFailure.invalidInput
        }
    }

    func identity() throws -> (vaultID: UUID, ownerID: UUID) {
        guard let row = try Self.rows(connection(), "SELECT vault,owner FROM vault_identity WHERE singleton=1;").first,
              let vault = UUID(uuidString: row[0]), let owner = UUID(uuidString: row[1]) else { throw VaultStorageFailure.invalidInput }
        return (vault, owner)
    }
    func validateAllSources() throws {
        var after: UUID?
        var count = 0
        while true {
            let ids = try catalog(after: after, limit: 100)
            guard !ids.isEmpty else { return }
            count += ids.count
            guard count <= 100 else { throw VaultStorageFailure.invalidInput }
            for id in ids { _ = try source(id: id) }
            after = ids.last
        }
    }

    func rebuildSearchIndex() throws {
        let db = try connection()
        try Self.execute(db, "BEGIN IMMEDIATE;")
        do {
            try Self.execute(db, "DELETE FROM search_index; INSERT INTO search_index(id,body) SELECT id,accepted FROM captures WHERE accepted IS NOT NULL;")
            try Self.execute(db, "COMMIT;")
        } catch { try? Self.execute(db, "ROLLBACK;"); throw error }
    }

    public func source(id: UUID) throws -> Data {
        let db = try connection()
        let stmt = try Self.prepare(db, "SELECT source,hash FROM captures WHERE id=?;")
        defer { sqlite3_finalize(stmt) }
        try Self.bind(stmt, strings: [id.uuidString])
        guard sqlite3_step(stmt) == SQLITE_ROW,
              let bytes = sqlite3_column_blob(stmt, 0), let hash = sqlite3_column_text(stmt, 1) else {
            throw VaultStorageFailure.recordUnavailable
        }
        let length = Int(sqlite3_column_bytes(stmt, 0))
        guard (1...(25 * 1024 * 1024)).contains(length), sqlite3_column_bytes(stmt, 1) == 64 else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        let data = Data(bytes: bytes, count: length)
        guard SHA256.hash(data: data).map({ String(format: "%02x", $0) }).joined() == String(cString: hash) else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        return data
    }

    public func capture(id: UUID) throws -> StoredCapture {
        let rows = try Self.rows(connection(), "SELECT hash,observation,accepted,revision,accepted IS NOT NULL,stage,attempts FROM captures WHERE id=?;", strings: [id.uuidString])
        guard let row = rows.first, let revision = Int(row[3]) else { throw VaultStorageFailure.recordUnavailable }
        return StoredCapture(id: id, sourceHash: row[0], observation: row[1],
            acceptedText: row[4] == "1" ? row[2] : nil, revision: revision, needsProcessing: row[5] == "received", processingAttempts: Int(row[6]) ?? 0,
            retryRequired: row[5] == "received" && (Int(row[6]) ?? 0) >= 3)
    }

    public func delete(id: UUID, expectedRevision: Int) throws {
        let db = try connection()
        try Self.execute(db, "BEGIN IMMEDIATE;")
        do {
            try Self.run(db, "DELETE FROM captures WHERE id=? AND revision=?;", strings: [id.uuidString, String(expectedRevision)])
            guard sqlite3_changes(db) == 1 else { throw VaultStorageFailure.staleRevision }
            try Self.run(db, "DELETE FROM search_index WHERE id=?;", strings: [id.uuidString])
            try Self.execute(db, "COMMIT;")
        } catch { try? Self.execute(db, "ROLLBACK;"); throw error }
    }

    private static func execute(_ db: OpaquePointer, _ sql: String) throws {
        guard sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
    }
    private static func prepare(_ db: OpaquePointer, _ sql: String) throws -> OpaquePointer {
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK, let stmt else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        return stmt
    }
    private static func bind(_ stmt: OpaquePointer, strings: [String]) throws {
        for (offset, value) in strings.enumerated() {
            guard value.utf8.count <= Int(Int32.max),
                  sqlite3_bind_text(stmt, Int32(offset + 1), value, Int32(value.utf8.count), transient) == SQLITE_OK else {
                throw VaultStorageFailure.storageUnavailable
            }
        }
    }
    private static func run(_ db: OpaquePointer, _ sql: String, strings: [String], blob: Data? = nil) throws {
        let stmt = try prepare(db, sql)
        defer { sqlite3_finalize(stmt) }
        try bind(stmt, strings: strings)
        if let blob {
            let result = blob.withUnsafeBytes { sqlite3_bind_blob(stmt, Int32(strings.count + 1), $0.baseAddress, Int32(blob.count), transient) }
            guard result == SQLITE_OK else { throw VaultStorageFailure.storageUnavailable }
        }
        guard sqlite3_step(stmt) == SQLITE_DONE else { throw VaultStorageFailure.storageUnavailable }
    }
    private static func rows(_ db: OpaquePointer, _ sql: String, strings: [String] = []) throws -> [[String]] {
        let stmt = try prepare(db, sql)
        defer { sqlite3_finalize(stmt) }
        try bind(stmt, strings: strings)
        var result: [[String]] = []
        while true {
            let state = sqlite3_step(stmt)
            if state == SQLITE_DONE { return result }
            guard state == SQLITE_ROW else { throw VaultStorageFailure.invalidKeyOrCorruptStore }
            guard (0..<sqlite3_column_count(stmt)).allSatisfy({ sqlite3_column_bytes(stmt, $0) <= 1_000_000 }) else {
                throw VaultStorageFailure.invalidInput
            }
            result.append((0..<sqlite3_column_count(stmt)).map { column in
                sqlite3_column_text(stmt, column).map {
                    String(decoding: UnsafeBufferPointer(start: $0, count: Int(sqlite3_column_bytes(stmt, column))), as: UTF8.self)
                } ?? ""
            })
        }
    }
    private static func scalar(_ db: OpaquePointer, _ sql: String) throws -> String {
        try rows(db, sql).first?.first ?? ""
    }
}

/// Actor facade for the low-level integration spike. Production views must use
/// the scoped ProtectedVault service, not this adapter.
public actor EncryptedVault {
    private let database: EncryptedDatabase
    public init(url: URL, key: Data, create: Bool, readOnly: Bool = false, maximumPages: Int = 786_432) throws {
        database = try EncryptedDatabase(url: url, key: key, create: create, readOnly: readOnly, maximumPages: maximumPages)
    }
    public func lock() { database.lock() }
    public func identity() throws -> (vaultID: UUID, ownerID: UUID) { try database.identity() }
    public func validateAllSources() throws { try database.validateAllSources() }
    public func receive(source: Data) throws -> UUID { try database.receive(source: source) }
    public func pendingJobs() throws -> [UUID] { try database.pendingJobs() }
    public func saveObservation(id: UUID, text: String) throws { try database.saveObservation(id: id, text: text) }
    public func approve(id: UUID, text: String, expectedRevision: Int) throws {
        try database.approve(id: id, text: text, expectedRevision: expectedRevision)
    }
    public func search(_ text: String) throws -> [UUID] { try database.search(text) }
    public func source(id: UUID) throws -> Data { try database.source(id: id) }
    public func capture(id: UUID) throws -> StoredCapture { try database.capture(id: id) }
    public func delete(id: UUID, expectedRevision: Int) throws { try database.delete(id: id, expectedRevision: expectedRevision) }
    public func snapshot(to destination: URL, recoveryKey: Data, destinationVaultID: UUID? = nil) throws { try database.snapshot(to: destination, recoveryKey: recoveryKey, destinationVaultID: destinationVaultID) }
}
