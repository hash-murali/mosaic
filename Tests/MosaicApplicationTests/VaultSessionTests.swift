import Foundation
import Testing
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers
import MosaicDomain
import MosaicStorage
@testable import MosaicApplication

private actor SyntheticCustody: VaultKeyCustody {
    let key: Data
    init(byte: UInt8 = 0x71) { key = Data(repeating: byte, count: 32) }
    var denied = false
    func create(vaultID: UUID) throws -> Data { if denied { throw SessionFailure.authenticationDenied }; return key }
    func unlock(vaultID: UUID) throws -> Data { try create(vaultID: vaultID) }
    func cancel() { }
    func deny() { denied = true }
}
private struct SyntheticOCR: VaultOCR {
    func recognize(_ source: Data) async throws -> String { "SYNTHETIC train 1900" }
}
private actor SuspendedOCR: VaultOCR {
    var continuation: CheckedContinuation<String, any Error>?
    var observers: [CheckedContinuation<Void, Never>] = []
    func recognize(_ source: Data) async throws -> String {
        try await withCheckedThrowingContinuation {
            continuation = $0
            observers.forEach { $0.resume() }; observers.removeAll()
        }
    }
    func waitStarted() async {
        if continuation != nil { return }
        await withCheckedContinuation { observers.append($0) }
    }
    func finish() { continuation?.resume(returning: "SYNTHETIC stale OCR"); continuation = nil }
}
private actor SuspendedCustody: VaultKeyCustody {
    var continuation: CheckedContinuation<Data, any Error>?
    var observers: [CheckedContinuation<Void, Never>] = []
    func create(vaultID: UUID) async throws -> Data { try await unlock(vaultID: vaultID) }
    func unlock(vaultID: UUID) async throws -> Data {
        try await withCheckedThrowingContinuation {
            continuation = $0; observers.forEach { $0.resume() }; observers.removeAll()
        }
    }
    func waitStarted() async {
        if continuation != nil { return }
        await withCheckedContinuation { observers.append($0) }
    }
    func cancel() { }
    func finish() { continuation?.resume(returning: Data(repeating: 0x71, count: 32)); continuation = nil }
}
private func fixtureDirectory() throws -> URL {
    let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
    let directory = root.appendingPathComponent(".verification/application-fixtures/\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    return directory
}
private func png() throws -> Data {
    let pixels = Data([255, 255, 255, 255, 0, 0, 0, 255])
    let provider = CGDataProvider(data: pixels as CFData)!
    let image = CGImage(width: 2, height: 1, bitsPerComponent: 8, bitsPerPixel: 32,
        bytesPerRow: 8, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.last.rawValue),
        provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)!
    let data = NSMutableData()
    let destination = CGImageDestinationCreateWithData(data, UTType.png.identifier as CFString, 1, nil)!
    CGImageDestinationAddImage(destination, image, nil)
    guard CGImageDestinationFinalize(destination) else { throw SessionFailure.invalidConfiguration }
    return data as Data
}

@Test func authenticatedReceiptResumesAfterRestartAndCorrectionPreservesSource() async throws {
    let directory = try fixtureDirectory(), id = UUID(), owner = UUID(), custody = SyntheticCustody()
    let url = directory.appendingPathComponent("vault.sqlite")
    let source = try png()
    let session = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: SyntheticOCR())
    await #expect(throws: SessionFailure.locked) { try await session.page() }
    try await session.open(create: true)
    let received = try await session.receive(source)
    #expect(try await session.page().first?.needsProcessing == true)
    await session.lock()
    let reopened = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: SyntheticOCR())
    try await reopened.open(create: false)
    try await reopened.resumeProcessing()
    #expect(try await reopened.page().first?.needsProcessing == false)
    try await reopened.save(received, text: "SYNTHETIC train 2000", revision: 2)
    await #expect(throws: VaultStorageFailure.staleRevision) {
        try await reopened.save(received, text: "SYNTHETIC stale edit", revision: 2)
    }
    #expect(try await reopened.source(received) == source)
    #expect(try await reopened.page().first?.acceptedText == "SYNTHETIC train 2000")
    #expect(try await reopened.search("2000") == [received])
    #expect(try await reopened.search("1900").isEmpty)
    try await reopened.discard(received, revision: 3)
    #expect(try await reopened.page().isEmpty)
    await reopened.lock()
    await custody.deny()
    await #expect(throws: SessionFailure.authenticationDenied) { try await reopened.open(create: false) }
    await #expect(throws: SessionFailure.locked) { try await reopened.page() }
}

@Test func lockDuringOCRKeepsDurableReceiptAndRejectsStaleCompletion() async throws {
    let directory = try fixtureDirectory(), id = UUID(), owner = UUID(), custody = SyntheticCustody(), worker = SuspendedOCR()
    let url = directory.appendingPathComponent("vault.sqlite")
    let session = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: worker)
    try await session.open(create: true)
    _ = try await session.receive(png())
    let processing = Task { try await session.resumeProcessing() }
    await worker.waitStarted()
    await session.lock()
    await worker.finish()
    await #expect(throws: SessionFailure.cancelled) { try await processing.value }
    let reopened = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: SyntheticOCR())
    try await reopened.open(create: false)
    #expect(try await reopened.page().first?.needsProcessing == true)
    #expect(try await reopened.page().first?.observation == "")
    try await reopened.resumeProcessing()
    #expect(try await reopened.page().first?.observation == "SYNTHETIC train 1900")
    await reopened.lock()
}

@Test func lockDuringAuthenticationCannotCreateOrReopenVault() async throws {
    let directory = try fixtureDirectory(), custody = SuspendedCustody()
    let url = directory.appendingPathComponent("vault.sqlite")
    let session = VaultSession(url: url, vaultID: UUID(), ownerID: UUID(), custody: custody)
    let opening = Task { try await session.open(create: true) }
    await custody.waitStarted()
    await session.lock()
    await custody.finish()
    await #expect(throws: SessionFailure.cancelled) { try await opening.value }
    #expect(!FileManager.default.fileExists(atPath: url.path))
    await #expect(throws: SessionFailure.locked) { try await session.page() }
}

private actor FailingOCR: VaultOCR {
    var calls = 0
    func recognize(_ source: Data) throws -> String {
        calls += 1
        throw SessionFailure.retryRequired
    }
    func count() -> Int { calls }
}
@Test func automaticRetryBudgetSurvivesRestartAndRequiresExplicitRetry() async throws {
    let directory = try fixtureDirectory(), id = UUID(), owner = UUID(), custody = SyntheticCustody(), worker = FailingOCR()
    let url = directory.appendingPathComponent("vault.sqlite")
    let session = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: worker, retryDelay: { _ in })
    try await session.open(create: true)
    let captureID = try await session.receive(png())
    try await session.resumeProcessing()
    #expect(await worker.count() == 3)
    #expect(try await session.page().first?.retryRequired == true)
    await session.lock()
    let reopened = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: worker, retryDelay: { _ in })
    try await reopened.open(create: false)
    try await reopened.resumeProcessing()
    #expect(await worker.count() == 3)
    #expect(try await reopened.page().first?.processingAttempts == 3)
    try await reopened.retry(captureID)
    try await reopened.resumeProcessing()
    #expect(await worker.count() == 6)
    #expect(try await reopened.source(captureID) == png())
    await reopened.lock()
}

@Test func authenticatedSnapshotRestoresWithoutOriginalCustodyAndRefusesOverwrite() async throws {
    let directory = try fixtureDirectory(), id = UUID(), owner = UUID(), custody = SyntheticCustody()
    let url = directory.appendingPathComponent("vault.sqlite"), backup = directory.appendingPathComponent("backup.sqlite")
    let session = VaultSession(url: url, vaultID: id, ownerID: owner, custody: custody, ocr: SyntheticOCR())
    try await session.open(create: true)
    let record = try await session.receive(png())
    try await session.resumeProcessing()
    try await session.save(record, text: "SYNTHETIC recovered correction", revision: 2)
    try await session.rebuildSearchIndex()
    let recoveryKey = Data(repeating: 0x75, count: 32)
    try await session.snapshot(to: backup, recoveryKey: recoveryKey)
    await session.lock()
    await custody.deny() // original authentication/custody unavailable
    let freshCustody = SyntheticCustody(byte: 0x79)
    let destination = directory.appendingPathComponent("restored.sqlite")
    let backupBytes = try Data(contentsOf: backup)
    let restoredIdentity = try await VaultSession.restore(snapshot: backup, recoveryKey: recoveryKey,
        destination: destination, custody: freshCustody)
    #expect(restoredIdentity.vaultID != id && restoredIdentity.ownerID == owner)
    #expect(try Data(contentsOf: backup) == backupBytes)
    #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        _ = try EncryptedVault(url: destination, key: Data(repeating: 0x71, count: 32), create: false)
    }
    let restored = VaultSession(url: destination, vaultID: restoredIdentity.vaultID, ownerID: owner, custody: freshCustody)
    try await restored.open(create: false)
    #expect(try await restored.source(record) == png())
    #expect(try await restored.page().first?.acceptedText == "SYNTHETIC recovered correction")
    await restored.lock()
    await #expect(throws: SessionFailure.invalidConfiguration) {
        try await VaultSession.restore(snapshot: backup, recoveryKey: recoveryKey, destination: destination, custody: freshCustody)
    }
    await #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        try await VaultSession.restore(snapshot: backup, recoveryKey: Data(repeating: 0x76, count: 32),
            destination: directory.appendingPathComponent("wrong-key.sqlite"), custody: freshCustody)
    }
}

@Test func protectedWorkspaceKeepsReviewLibraryAndSearchConsistent() async throws {
    let directory = try fixtureDirectory()
    let session = VaultSession(url: directory.appendingPathComponent("vault.sqlite"), vaultID: UUID(),
        ownerID: UUID(), custody: SyntheticCustody(), ocr: SyntheticOCR())
    try await session.open(create: true)
    let id = try await session.receive(png())
    try await session.resumeProcessing()
    var workspace = VaultWorkspace(captures: try await session.page())
    #expect(workspace.visible(in: .inbox, unlocked: true).map(\.id) == [id])
    #expect(workspace.visible(in: .library, unlocked: true).isEmpty)
    #expect(workspace.visible(in: .search, unlocked: true, matches: [id]).isEmpty)
    try await session.save(id, text: "SYNTHETIC approved destination 2000", revision: 2)
    workspace = VaultWorkspace(captures: try await session.page())
    #expect(workspace.visible(in: .inbox, unlocked: true).isEmpty)
    #expect(workspace.visible(in: .library, unlocked: true).map(\.id) == [id])
    let matches = Set(try await session.search("2000"))
    #expect(workspace.visible(in: .search, unlocked: true, matches: matches).map(\.id) == [id])
    #expect(workspace.visible(in: .search, unlocked: true, matches: []).isEmpty)
    #expect(workspace.visible(in: .search, unlocked: true).isEmpty)
    try await session.discard(id, revision: 3)
    workspace = VaultWorkspace(captures: try await session.page())
    #expect(workspace.visible(in: .library, unlocked: true).isEmpty)
    #expect(try await session.search("2000").isEmpty)
    await session.lock()
}

@Test func protectedWorkspaceNeverReturnsContentWhileLocked() async throws {
    let directory = try fixtureDirectory()
    let session = VaultSession(url: directory.appendingPathComponent("vault.sqlite"), vaultID: UUID(),
        ownerID: UUID(), custody: SyntheticCustody(), ocr: SyntheticOCR())
    try await session.open(create: true)
    let id = try await session.receive(png())
    try await session.resumeProcessing()
    try await session.save(id, text: "SYNTHETIC accepted content", revision: 2)
    let stale = VaultWorkspace(captures: try await session.page())
    await session.lock()
    for tab in VaultWorkspaceTab.allCases {
        #expect(stale.visible(in: tab, unlocked: false, matches: [id]).isEmpty)
    }
}

@Test func failedRecoveryPreservesBackupAndDoesNotPublishDestination() async throws {
    let directory = try fixtureDirectory()
    let session = VaultSession(url: directory.appendingPathComponent("vault.sqlite"), vaultID: UUID(),
        ownerID: UUID(), custody: SyntheticCustody(), ocr: SyntheticOCR())
    try await session.open(create: true)
    let id = try await session.receive(png())
    try await session.resumeProcessing()
    try await session.save(id, text: "SYNTHETIC retained after recovery denial", revision: 2)
    let backup = directory.appendingPathComponent("backup.sqlite")
    let key = Data((0..<32).map { UInt8($0 * 7) })
    try await session.snapshot(to: backup, recoveryKey: key)
    let before = try Data(contentsOf: backup)
    let denied = SyntheticCustody()
    await denied.deny()
    let destination = directory.appendingPathComponent("denied.sqlite")
    await #expect(throws: SessionFailure.authenticationDenied) {
        try await VaultSession.restore(snapshot: backup, recoveryKey: key, destination: destination, custody: denied)
    }
    #expect(!FileManager.default.fileExists(atPath: destination.path))
    #expect(try Data(contentsOf: backup) == before)
    #expect(try await session.page().first?.acceptedText == "SYNTHETIC retained after recovery denial")
    var tampered = before
    tampered[100] ^= 0xFF
    let corrupt = directory.appendingPathComponent("tampered.sqlite")
    try tampered.write(to: corrupt)
    let corruptDestination = directory.appendingPathComponent("corrupt-destination.sqlite")
    await #expect(throws: VaultStorageFailure.invalidKeyOrCorruptStore) {
        try await VaultSession.restore(snapshot: corrupt, recoveryKey: key, destination: corruptDestination, custody: SyntheticCustody())
    }
    #expect(!FileManager.default.fileExists(atPath: corruptDestination.path))
    #expect(try Data(contentsOf: backup) == before)
    await session.lock()
}

private actor UnavailableOriginalCustody: VaultKeyCustody {
    let original: UUID
    init(original: UUID) { self.original = original }
    func create(vaultID: UUID) throws -> Data {
        guard vaultID != original else { throw SessionFailure.keyUnavailable }
        return Data(repeating: 0x79, count: 32)
    }
    func unlock(vaultID: UUID) throws -> Data { try create(vaultID: vaultID) }
    func cancel() { }
}
@Test func recoveryDoesNotRequestUnavailableOriginalCustody() async throws {
    let directory = try fixtureDirectory(), originalID = UUID(), owner = UUID()
    let original = VaultSession(url: directory.appendingPathComponent("original.sqlite"), vaultID: originalID, ownerID: owner, custody: SyntheticCustody(), ocr: SyntheticOCR())
    try await original.open(create: true)
    let record = try await original.receive(png())
    try await original.resumeProcessing()
    let capture = try #require(try await original.page().first)
    try await original.save(record, text: "SYNTHETIC independent custody", revision: capture.revision)
    let backup = directory.appendingPathComponent("independent.sqlite"), key = Data(repeating: 0x75, count: 32)
    try await original.snapshot(to: backup, recoveryKey: key)
    await original.lock()
    let custody = UnavailableOriginalCustody(original: originalID)
    let destination = directory.appendingPathComponent("new-profile.sqlite")
    let identity = try await VaultSession.restore(snapshot: backup, recoveryKey: key, destination: destination, custody: custody)
    #expect(identity.vaultID != originalID && identity.ownerID == owner)
    let restored = VaultSession(url: destination, vaultID: identity.vaultID, ownerID: owner, custody: custody, ocr: SyntheticOCR())
    try await restored.open(create: false)
    #expect(try await restored.search("independent") == [record])
    await restored.lock()
    // The original encrypted identity and backup are not rebound in place.
    let source = VaultSession(url: directory.appendingPathComponent("original.sqlite"), vaultID: originalID, ownerID: owner, custody: SyntheticCustody(), ocr: SyntheticOCR())
    try await source.open(create: false)
    #expect(try await source.search("independent") == [record])
    await source.lock()
}

#if canImport(Security) && canImport(LocalAuthentication)
import Security
@Test func keyCustodyErrorsRemainDistinctWithoutReadingKeychain() throws {
    #expect(throws: SessionFailure.keyNotFound) {
        try AppleVaultKeyCustody.validatedKey(status: errSecItemNotFound, data: nil)
    }
    #expect(throws: SessionFailure.keySigningUnavailable) {
        try AppleVaultKeyCustody.validatedKey(status: errSecMissingEntitlement, data: nil)
    }
    #expect(throws: SessionFailure.keyAccessDenied) {
        try AppleVaultKeyCustody.validatedKey(status: errSecAuthFailed, data: nil)
    }
    #expect(throws: SessionFailure.keyInteractionUnavailable) {
        try AppleVaultKeyCustody.validatedKey(status: errSecInteractionNotAllowed, data: nil)
    }
    #expect(throws: SessionFailure.invalidKeyMaterial) {
        try AppleVaultKeyCustody.validatedKey(status: errSecSuccess, data: Data(repeating: 0x71, count: 31))
    }
    #expect(throws: SessionFailure.keyOperationFailed(-12345)) {
        try AppleVaultKeyCustody.validatedKey(status: -12345, data: nil)
    }
    #expect(try AppleVaultKeyCustody.validatedKey(status: errSecSuccess, data: Data(repeating: 0x71, count: 32)) == Data(repeating: 0x71, count: 32))
}
#endif

#if canImport(Security) && canImport(LocalAuthentication)
@Test func protectedCustodyRequiresNativeAppLaunchBeforeAuthentication() throws {
    #expect(throws: SessionFailure.nativeAppRequired) {
        try AppleVaultKeyCustody.requireNativeApp(bundleURL: URL(fileURLWithPath: "/SYNTHETIC/build/debug"))
    }
    try AppleVaultKeyCustody.requireNativeApp(bundleURL: URL(fileURLWithPath: "/SYNTHETIC/Mosaic.app"))
}
#endif
