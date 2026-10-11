#if os(macOS)
import Foundation
import Testing
import ImageIO
import CoreGraphics
import MosaicApplication
@testable import MosaicDemo

private actor FixtureCustody: VaultKeyCustody {
    func create(vaultID: UUID) -> Data { Data(repeating: 0x63, count: 32) }
    func unlock(vaultID: UUID) -> Data { Data(repeating: 0x63, count: 32) }
    func cancel() { }
}
private struct FixtureOCR: VaultOCR {
    func recognize(_ source: Data) -> String { "SYNTHETIC train 1900" }
}
@MainActor private func idle(_ model: ProtectedDemoModel) async throws {
    let deadline = ContinuousClock.now.advanced(by: .seconds(5))
    while model.working {
        guard ContinuousClock.now < deadline else { Issue.record("Model operation timed out"); return }
        await Task.yield()
    }
}
private func root() -> URL {
    URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent()
        .deletingLastPathComponent().appendingPathComponent(".verification/model-fixtures/" + UUID().uuidString)
}

@Test @MainActor func mainModelSharesSavedCorrectionAndSearchThenClearsOnLock() async throws {
    let model = ProtectedDemoModel(root: root(), custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    model.open(); try await idle(model)
    #expect(model.unlocked, Comment(rawValue: model.message))
    model.addSample(); try await idle(model)
    model.resume(); try await idle(model)
    let capture = try #require(model.captures.first)
    model.editText = "SYNTHETIC accepted train 2000"
    model.save(capture); try await idle(model)
    model.query = "2000"
    model.search(); try await idle(model)
    #expect(model.searchResults == [capture.id])
    model.select(capture.id); try await idle(model)
    #expect(model.selectedImage != nil)
    model.lock()
    #expect(!model.unlocked && model.captures.isEmpty && model.selectedImage == nil)
    #expect(model.query.isEmpty && model.searchResults == nil && model.editText.isEmpty)
    model.open(); try await idle(model)
    #expect(model.unlocked, Comment(rawValue: model.message))
    #expect(model.captures.first?.acceptedText == "SYNTHETIC accepted train 2000")
    model.lock()
}

@Test @MainActor func mainModelLockClearsRecoveryMaterialAndApprovalDraft() async throws {
    let model = ProtectedDemoModel(root: root(), custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    model.open(); try await idle(model)
    model.recoveryKeyText = String(repeating: "6", count: 64)
    model.restoreKeyText = String(repeating: "7", count: 64)
    model.recordedRecoveryKey = true; model.editing = true; model.editText = "SYNTHETIC draft"
    model.lock()
    #expect(model.recoveryKeyText.isEmpty && model.restoreKeyText.isEmpty && !model.recordedRecoveryKey)
    #expect(!model.editing && model.editText.isEmpty)
}

@Test func settingsIsNotAContentCollection() {
    #expect(VaultWorkspaceTab.allCases.contains(.settings))
    let workspace = VaultWorkspace(captures: [])
    #expect(workspace.visible(in: .settings, unlocked: true).isEmpty)
    #expect(workspace.visible(in: .settings, unlocked: false).isEmpty)
}
#endif

#if os(macOS)
private actor ClosingFixtureCustody: VaultKeyCustody {
    var calls = 0
    var closing: CheckedContinuation<Void, Never>?
    var observers: [CheckedContinuation<Void, Never>] = []
    func create(vaultID: UUID) -> Data { calls += 1; return Data(repeating: 0x64, count: 32) }
    func unlock(vaultID: UUID) -> Data { calls += 1; return Data(repeating: 0x64, count: 32) }
    func cancel() async {
        await withCheckedContinuation { continuation in
            closing = continuation
            observers.forEach { $0.resume() }; observers.removeAll()
        }
    }
    func waitForClose() async {
        if closing != nil { return }
        await withCheckedContinuation { observers.append($0) }
    }
    func finishClose() { closing?.resume(); closing = nil }
    func authenticationCalls() -> Int { calls }
}

@Test @MainActor func reopeningWaitsForPreviousCustodyToClose() async throws {
    let custody = ClosingFixtureCustody()
    let model = ProtectedDemoModel(root: root(), custodyFactory: { custody }, ocr: FixtureOCR())
    model.open(); try await idle(model)
    #expect(model.unlocked)
    model.lock()
    await custody.waitForClose()
    model.open()
    await Task.yield()
    #expect(await custody.authenticationCalls() == 1)
    #expect(!model.unlocked && model.captures.isEmpty)
    await custody.finishClose()
    try await idle(model)
    #expect(model.unlocked)
    #expect(await custody.authenticationCalls() == 2)
    model.lock()
    await custody.waitForClose()
    await custody.finishClose()
}
#endif

#if os(macOS)
@Test @MainActor func selectedSyntheticFileJoinsProtectedCollectionAndDeduplicates() async throws {
    let directory = root()
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    let producer = ProtectedDemoModel(root: directory.appendingPathComponent("producer"), custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    producer.open(); try await idle(producer)
    producer.addSample(); try await idle(producer)
    let sample = try #require(producer.captures.first)
    producer.select(sample.id); try await idle(producer)
    let image = try #require(producer.selectedImage)
    let bytes = NSMutableData()
    let destination = try #require(CGImageDestinationCreateWithData(bytes, "public.png" as CFString, 1, nil))
    CGImageDestinationAddImage(destination, image, nil)
    #expect(CGImageDestinationFinalize(destination))
    let file = directory.appendingPathComponent("invented.png")
    try (bytes as Data).write(to: file)
    producer.lock()
    let model = ProtectedDemoModel(root: directory.appendingPathComponent("consumer"), custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    model.open(); try await idle(model)
    model.importSelectedFile(file); try await idle(model)
    #expect(model.captures.count == 1)
    model.resume(); try await idle(model)
    let capture = try #require(model.captures.first)
    model.editText = "SYNTHETIC imported railway"
    model.save(capture); try await idle(model)
    model.importSelectedFile(file); try await idle(model)
    #expect(model.captures.count == 1)
    #expect(model.captures.first?.acceptedText == "SYNTHETIC imported railway")
    model.query = "railway"; model.search(); try await idle(model)
    #expect(model.searchResults == [capture.id])
    model.lock()
    model.importSelectedFile(file); try await idle(model)
    #expect(model.captures.isEmpty && !model.unlocked)
}

@Test @MainActor func invalidSelectedFileAddsNoProtectedRecord() async throws {
    let directory = root()
    let model = ProtectedDemoModel(root: directory, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    model.open(); try await idle(model)
    let file = directory.appendingPathComponent("invalid.png")
    try Data("SYNTHETIC invalid image".utf8).write(to: file)
    model.importSelectedFile(file); try await idle(model)
    #expect(model.captures.isEmpty)
    model.lock(); model.open(); try await idle(model)
    #expect(model.unlocked && model.captures.isEmpty)
    model.lock()
}
#endif

#if os(macOS)
@Test @MainActor func chosenVaultFolderPersistsWithoutSplittingCollection() async throws {
    let control = root()
    let selected = root()
    try FileManager.default.createDirectory(at: selected, withIntermediateDirectories: true)
    let model = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    try model.useVaultFolder(selected)
    model.open(); try await idle(model)
    #expect(model.unlocked)
    model.addSample(); try await idle(model)
    model.resume(); try await idle(model)
    let record = try #require(model.captures.first)
    model.editText = "SYNTHETIC selected location"
    model.save(record); try await idle(model)
    model.lock()
    // Await actual close before constructing another app instance.
    model.open(); try await idle(model); model.lock()
    let reopened = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    reopened.open(); try await idle(reopened)
    #expect(reopened.unlocked)
    #expect(reopened.captures.first?.acceptedText == "SYNTHETIC selected location")
    #expect(!FileManager.default.fileExists(atPath: control.appendingPathComponent("vault.sqlite").path))
    reopened.lock()
}

@Test @MainActor func unavailableSelectedFolderDoesNotCreateFallbackVault() async throws {
    let control = root(), selected = root()
    try FileManager.default.createDirectory(at: selected, withIntermediateDirectories: true)
    let model = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    try model.useVaultFolder(selected)
    let relocated = selected.appendingPathExtension("unavailable")
    try FileManager.default.moveItem(at: selected, to: relocated)
    // A moved bookmark may follow file identity; it must never recreate the absent path.
    model.open(); try await idle(model)
    #expect(!FileManager.default.fileExists(atPath: selected.path))
    #expect(!FileManager.default.fileExists(atPath: control.appendingPathComponent("vault.sqlite").path))
    model.lock()
}

@Test @MainActor func vaultFolderChangeRequiresLockedStateAndExistingDirectory() async throws {
    let control = root(), selected = root()
    let model = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    #expect(throws: (any Error).self) { try model.useVaultFolder(selected) }
    model.open(); try await idle(model)
    #expect(throws: (any Error).self) { try model.useVaultFolder(control) }
    model.lock()
}
#endif

#if os(macOS)
@Test @MainActor func restoreBeforeFirstUnlockUsesRememberedVaultFolder() async throws {
    let control = root(), selected = root()
    try FileManager.default.createDirectory(at: selected, withIntermediateDirectories: true)
    let original = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    try original.useVaultFolder(selected)
    original.open(); try await idle(original)
    original.addSample(); try await idle(original)
    original.resume(); try await idle(original)
    let capture = try #require(original.captures.first)
    original.editText = "SYNTHETIC restored selected collection"
    original.save(capture); try await idle(original)
    original.recoveryKeyText = String(repeating: "73", count: 32)
    original.recordedRecoveryKey = true
    let backup = control.appendingPathComponent("synthetic-backup.sqlite")
    original.backupSelectedFile(backup); try await idle(original)
    #expect(original.message == "Encrypted backup created. Keep its independent key separately.", Comment(rawValue: original.message))
    #expect(FileManager.default.fileExists(atPath: backup.path))
    original.lock()
    let fresh = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    fresh.restoreKeyText = String(repeating: "73", count: 32)
    fresh.restoreSelectedBackup(backup); try await idle(fresh)
    #expect(fresh.message == "Restored into a new profile. Unlock to inspect synthetic records.", Comment(rawValue: fresh.message))
    fresh.open(); try await idle(fresh)
    #expect(fresh.unlocked)
    #expect(fresh.captures.first?.acceptedText == "SYNTHETIC restored selected collection")
    #expect(FileManager.default.fileExists(atPath: selected.appendingPathComponent("active-profile.json").path))
    #expect(!FileManager.default.fileExists(atPath: control.appendingPathComponent("active-profile.json").path))
    fresh.lock()
}
#endif

#if os(macOS)
@Test @MainActor func immediateOpenLockThenReopenDoesNotDeadlock() async throws {
    let model = ProtectedDemoModel(root: root(), custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    model.open(); model.lock(); model.open()
    try await idle(model)
    #expect(model.unlocked)
    model.lock()
}
@Test @MainActor func immediateRestoreLockThenOpenDoesNotDeadlock() async throws {
    let directory = root()
    let model = ProtectedDemoModel(root: directory, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    model.restoreKeyText = String(repeating: "73", count: 32)
    model.restoreSelectedBackup(directory.appendingPathComponent("unused-synthetic-backup.sqlite"))
    model.lock(); model.open()
    try await idle(model)
    #expect(model.unlocked)
    model.lock()
}
#endif

#if os(macOS)
@Test @MainActor func corruptBookmarkDoesNotOpenDefaultCollection() async throws {
    let control = root(), selected = root()
    try FileManager.default.createDirectory(at: selected, withIntermediateDirectories: true)
    let model = ProtectedDemoModel(root: control, custodyFactory: { FixtureCustody() }, ocr: FixtureOCR())
    try model.useVaultFolder(selected)
    try Data("SYNTHETIC invalid bookmark".utf8).write(to: control.appendingPathComponent("vault-location.bookmark"))
    model.open(); try await idle(model)
    #expect(!model.unlocked && model.captures.isEmpty)
    #expect(!FileManager.default.fileExists(atPath: control.appendingPathComponent("vault.sqlite").path))
    model.lock()
}
#endif
