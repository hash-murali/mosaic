import Foundation
import MosaicStorage
import Darwin

/// Synthetic-only recovery drill. No Keychain, authentication, images or user
/// vaults. Fixed published fixture keys are deliberately NOT production secrets.
@main struct MosaicRecoveryCheck {
    static let source = Data("SYNTHETIC RECOVERY SOURCE 2026".utf8)
    static let originalKey = Data(repeating: 0x54, count: 32)
    static let recoveryKey = Data(repeating: 0x55, count: 32)

    static func main() async {
        do {
            let arguments = CommandLine.arguments
            if arguments.count == 3, ["create", "restore", "crash-receipt", "crash-observation", "crash-approval", "check-receipt", "check-observation", "check-approval"].contains(arguments[1]) {
                let directory = URL(fileURLWithPath: arguments[2], isDirectory: true)
                // This executable can only use its generated repository-local fixture directory.
                let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
                    .deletingLastPathComponent().deletingLastPathComponent()
                    .appendingPathComponent(".verification/recovery-process", isDirectory: true)
                guard directory.standardizedFileURL.deletingLastPathComponent() == root.standardizedFileURL,
                      UUID(uuidString: directory.lastPathComponent) != nil,
                      directory.resolvingSymlinksInPath() == directory.standardizedFileURL else {
                    throw VaultStorageFailure.invalidInput
                }
                if arguments[1] == "create" { try await create(directory) }
                else if arguments[1] == "restore" { try await restore(directory) }
                else if arguments[1].hasPrefix("crash-") { try await crash(directory, stage: arguments[1]) }
                else { try await verifyCheckpoint(directory, stage: arguments[1]) }
            } else if arguments.count == 1 {
                let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
                    .deletingLastPathComponent().deletingLastPathComponent()
                    .appendingPathComponent(".verification/recovery-process", isDirectory: true)
                let directory = root.appendingPathComponent(UUID().uuidString, isDirectory: true)
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
                // Each child terminates before the next starts. No live database
                // handle, actor state or cached key crosses the process boundary.
                try child("create", directory)
                try child("restore", directory)
                print("PASS: independent-process synthetic restore; no Keychain dependency")
                for stage in ["receipt", "observation", "approval"] {
                    let fixture = root.appendingPathComponent(UUID().uuidString, isDirectory: true)
                    try FileManager.default.createDirectory(at: fixture, withIntermediateDirectories: true)
                    try child("crash-" + stage, fixture)
                    try child("check-" + stage, fixture)
                    print("PASS: abrupt process exit after " + stage + "; durable state restored")
                }
            } else { throw VaultStorageFailure.invalidInput }
        } catch {
            print("FAIL: synthetic recovery check")
            exit(1)
        }
    }

    static func child(_ mode: String, _ directory: URL) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: CommandLine.arguments[0])
        process.arguments = [mode, directory.path]
        process.standardOutput = FileHandle.nullDevice
        process.standardError = FileHandle.nullDevice
        try process.run()
        process.waitUntilExit()
        guard process.terminationReason == .exit, process.terminationStatus == 0 else {
            throw VaultStorageFailure.storageUnavailable
        }
    }

    static func crash(_ directory: URL, stage: String) async throws {
        let vault = try EncryptedVault(url: directory.appendingPathComponent("crash.sqlite"), key: originalKey, create: true)
        let id = try await vault.receive(source: source)
        try Data(id.uuidString.utf8).write(to: directory.appendingPathComponent("synthetic-id.txt"), options: .atomic)
        if stage != "crash-receipt" { try await vault.saveObservation(id: id, text: "SYNTHETIC observed train 1900") }
        if stage == "crash-approval" { try await vault.approve(id: id, text: "SYNTHETIC accepted train 2000", expectedRevision: 2) }
        _exit(0) // child only: no actor/database deinit or graceful checkpoint
    }
    static func verifyCheckpoint(_ directory: URL, stage: String) async throws {
        let idText = try String(contentsOf: directory.appendingPathComponent("synthetic-id.txt"), encoding: .utf8)
        guard let id = UUID(uuidString: idText) else { throw VaultStorageFailure.invalidInput }
        let vault = try EncryptedVault(url: directory.appendingPathComponent("crash.sqlite"), key: originalKey, create: false)
        guard try await vault.source(id: id) == source else { throw VaultStorageFailure.invalidKeyOrCorruptStore }
        let capture = try await vault.capture(id: id)
        if stage == "check-receipt" {
            guard capture.needsProcessing, capture.observation.isEmpty,
                  try await vault.pendingJobs() == [id] else { throw VaultStorageFailure.invalidInput }
        } else {
            guard !capture.needsProcessing, capture.observation == "SYNTHETIC observed train 1900" else { throw VaultStorageFailure.invalidInput }
        }
        if stage == "check-approval" {
            guard capture.acceptedText == "SYNTHETIC accepted train 2000", try await vault.search("2000") == [id],
                  try await vault.search("1900").isEmpty else { throw VaultStorageFailure.invalidInput }
        } else {
            guard capture.acceptedText == nil, try await vault.search("1900").isEmpty else { throw VaultStorageFailure.invalidInput }
        }
        await vault.lock()
    }

    static func create(_ directory: URL) async throws {
        let vault = try EncryptedVault(url: directory.appendingPathComponent("source.sqlite"), key: originalKey, create: true)
        let id = try await vault.receive(source: source)
        try await vault.saveObservation(id: id, text: "SYNTHETIC observed train 1900")
        try await vault.approve(id: id, text: "SYNTHETIC accepted train 2000", expectedRevision: 2)
        try await vault.snapshot(to: directory.appendingPathComponent("recovery.sqlite"), recoveryKey: recoveryKey)
        await vault.lock()
    }

    static func restore(_ directory: URL) async throws {
        let backup = directory.appendingPathComponent("recovery.sqlite")
        do {
            let wrong = try EncryptedVault(url: backup, key: originalKey, create: false)
            await wrong.lock()
            throw VaultStorageFailure.invalidInput
        } catch VaultStorageFailure.invalidKeyOrCorruptStore { }
        let vault = try EncryptedVault(url: backup, key: recoveryKey, create: false)
        let matches = try await vault.search("2000")
        guard matches.count == 1, let id = matches.first,
              try await vault.source(id: id) == source,
              try await vault.capture(id: id).observation == "SYNTHETIC observed train 1900",
              try await vault.capture(id: id).acceptedText == "SYNTHETIC accepted train 2000",
              try await vault.search("1900").isEmpty,
              try await vault.pendingJobs().isEmpty else {
            throw VaultStorageFailure.invalidKeyOrCorruptStore
        }
        await vault.lock()
    }
}
