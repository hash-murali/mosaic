#if os(macOS)
import AppKit
import SwiftUI
import ImageIO
import UniformTypeIdentifiers
import Security
import MosaicCore
import MosaicApplication
import MosaicStorage

/// One protected workspace. Tests inject fake custody and generated fixtures;
/// default app composition always uses platform authentication.
@MainActor final class ProtectedDemoModel: ObservableObject {
    private struct Identity: Codable {
        let vaultID: UUID
        let ownerID: UUID
        var setupComplete: Bool
    }
    @Published var unlocked = false
    @Published var working = false
    @Published var message = "Synthetic test vault. Choose invented test images only."
    @Published var captures: [StoredCapture] = []
    @Published var selected: UUID?
    @Published var selectedImage: CGImage?
    @Published var editing = false
    @Published var editText = ""
    @Published var recoveryKeyText = ""
    @Published var restoreKeyText = ""
    @Published var recordedRecoveryKey = false
    @Published var query = ""
    @Published var searchResults: [UUID]?
    private var session: VaultSession?
    private var recoveryCustody: (any VaultKeyCustody)?
    private var lastActivity = Date()
    private var task: Task<Void, Never>?
    private var locking: Task<Void, Never>?
    private var epoch = UUID()
    private var root: URL
    private var base: URL
    private let configurationRoot: URL
    private var scopedFolder: URL?
    private let custodyFactory: @MainActor () -> any VaultKeyCustody
    private let ocr: any VaultOCR
    init(root: URL = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
            .deletingLastPathComponent().deletingLastPathComponent()
            .appendingPathComponent(".verification/protected-demo", isDirectory: true),
         custodyFactory: @escaping @MainActor () -> any VaultKeyCustody = { AppleVaultKeyCustody() },
         ocr: any VaultOCR = LocalVaultOCR()) {
        self.root = root; base = root; configurationRoot = root; self.custodyFactory = custodyFactory; self.ocr = ocr
    }
    /// The owner selects an existing synthetic-vault directory; no migration or scan.
    func useVaultFolder(_ folder: URL) throws {
        guard !unlocked, !working else { throw SessionFailure.invalidConfiguration }
        let folder = folder.standardizedFileURL
        var directory: ObjCBool = false
        guard folder.isFileURL, folder.resolvingSymlinksInPath() == folder,
              FileManager.default.fileExists(atPath: folder.path, isDirectory: &directory), directory.boolValue else {
            throw SessionFailure.invalidConfiguration
        }
        let bookmark = try folder.bookmarkData(options: [.withSecurityScope], includingResourceValuesForKeys: nil, relativeTo: nil)
        guard bookmark.count <= 65536 else { throw SessionFailure.invalidConfiguration }
        try ensureConfigurationDirectory()
        try bookmark.write(to: configurationRoot.appendingPathComponent("vault-location.bookmark"), options: .atomic)
        base = folder; root = folder
        message = "Vault folder selected. Unlock to open its protected collection. Existing folders are not moved or replaced."
    }
    func chooseVaultFolder() {
        guard !unlocked, !working else { return }
        let panel = NSOpenPanel()
        panel.canChooseFiles = false; panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false; panel.canCreateDirectories = false
        panel.message = "Choose an existing folder for synthetic Mosaic content. Existing vaults are opened; content is not moved."
        guard panel.runModal() == .OK, let folder = panel.url else { return }
        let scoped = folder.startAccessingSecurityScopedResource()
        defer { if scoped { folder.stopAccessingSecurityScopedResource() } }
        do { try useVaultFolder(folder) }
        catch { message = "Folder could not be selected. Existing vault selection is unchanged." }
    }
    private func ensureConfigurationDirectory() throws {
        guard configurationRoot.resolvingSymlinksInPath().path == configurationRoot.standardizedFileURL.path else { throw SessionFailure.invalidConfiguration }
        var directory: ObjCBool = false
        if FileManager.default.fileExists(atPath: configurationRoot.path, isDirectory: &directory) {
            guard directory.boolValue else { throw SessionFailure.invalidConfiguration }
            return
        }
        guard FileManager.default.fileExists(atPath: configurationRoot.deletingLastPathComponent().path, isDirectory: &directory), directory.boolValue else { throw SessionFailure.invalidConfiguration }
        try FileManager.default.createDirectory(at: configurationRoot, withIntermediateDirectories: false)
    }
    private func resolveVaultFolder() throws {
        if let scopedFolder { scopedFolder.stopAccessingSecurityScopedResource(); self.scopedFolder = nil }
        let bookmarkFile = configurationRoot.appendingPathComponent("vault-location.bookmark")
        guard FileManager.default.fileExists(atPath: bookmarkFile.path) else {
            try ensureConfigurationDirectory()
            base = configurationRoot; root = base; return
        }
        guard bookmarkFile.resolvingSymlinksInPath() == bookmarkFile.standardizedFileURL else { throw SessionFailure.invalidConfiguration }
        let handle = try FileHandle(forReadingFrom: bookmarkFile)
        defer { try? handle.close() }
        let bytes = try handle.read(upToCount: 65537) ?? Data()
        guard bytes.count <= 65536 else { throw SessionFailure.invalidConfiguration }
        var stale = false
        let folder = try URL(resolvingBookmarkData: bytes,
            options: [.withSecurityScope, .withoutUI, .withoutMounting], relativeTo: nil, bookmarkDataIsStale: &stale)
        guard !stale else { throw SessionFailure.invalidConfiguration }
        let scoped = folder.startAccessingSecurityScopedResource()
        var directory: ObjCBool = false
        guard folder.isFileURL, folder.resolvingSymlinksInPath() == folder.standardizedFileURL,
              FileManager.default.fileExists(atPath: folder.path, isDirectory: &directory), directory.boolValue else {
            if scoped { folder.stopAccessingSecurityScopedResource() }
            throw SessionFailure.invalidConfiguration
        }
        if scoped { scopedFolder = folder }
        base = folder; root = folder
    }
    func activity() { lastActivity = Date() }
    func checkIdle() { if unlocked && Date().timeIntervalSince(lastActivity) >= 300 { lock() } }

    func open() {
        guard !working else { return }
        working = true
        activity()
        let ticket = epoch, precedingLock = locking
        task = Task {
            do {
                try Task.checkCancellation()
                await precedingLock?.value
                try Task.checkCancellation()
                guard epoch == ticket else { return }
                locking = nil
                try resolveVaultFolder()
                let pointer = base.appendingPathComponent("active-profile.json")
                if FileManager.default.fileExists(atPath: pointer.path) {
                    guard pointer.resolvingSymlinksInPath().path == pointer.standardizedFileURL.path else { throw SessionFailure.invalidConfiguration }
                    let file = try FileHandle(forReadingFrom: pointer)
                    defer { try? file.close() }
                    let bytes = try file.read(upToCount: 129) ?? Data()
                    guard bytes.count <= 128,
                          let profile = UUID(uuidString: String(decoding: bytes, as: UTF8.self)) else { throw SessionFailure.invalidConfiguration }
                    root = base.appendingPathComponent("restore-\(profile.uuidString)", isDirectory: true)
                }
                guard root.resolvingSymlinksInPath() == root.standardizedFileURL else { throw SessionFailure.invalidConfiguration }
                let metadata = root.appendingPathComponent("identity.json")
                let database = root.appendingPathComponent("vault.sqlite")
                var identity: Identity
                if FileManager.default.fileExists(atPath: metadata.path) {
                    guard metadata.resolvingSymlinksInPath().path == metadata.standardizedFileURL.path else { throw SessionFailure.invalidConfiguration }
                    let file = try FileHandle(forReadingFrom: metadata)
                    defer { try? file.close() }
                    let bytes = try file.read(upToCount: 1025) ?? Data()
                    guard bytes.count <= 1024 else { throw SessionFailure.invalidConfiguration }
                    identity = try JSONDecoder().decode(Identity.self, from: bytes)
                } else {
                    guard !FileManager.default.fileExists(atPath: database.path) else { throw SessionFailure.invalidConfiguration }
                    try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
                    identity = Identity(vaultID: UUID(), ownerID: UUID(), setupComplete: false)
                    try JSONEncoder().encode(identity).write(to: metadata, options: .atomic)
                }
                let service = VaultSession(url: database, vaultID: identity.vaultID, ownerID: identity.ownerID,
                    custody: custodyFactory(), ocr: ocr)
                session = service
                try await service.open(create: !identity.setupComplete)
                guard epoch == ticket else { await service.lock(); return }
                identity.setupComplete = true
                try JSONEncoder().encode(identity).write(to: metadata, options: .atomic)
                let loaded = try await service.page()
                try Task.checkCancellation()
                guard epoch == ticket else { return }
                unlocked = true
                captures = loaded
                message = "Unlocked. Records are encrypted and persist between launches."
                working = false
            } catch {
                guard epoch == ticket else { return }
                await session?.lock()
                guard epoch == ticket else { return }
                unlocked = false
                captures = []
                selectedImage = nil
                let code: String
                if let failure = error as? VaultStorageFailure { code = String(describing: failure) }
                else if let failure = error as? SessionFailure { code = String(describing: failure) }
                else { code = "storageUnavailable" }
                if error as? SessionFailure == .nativeAppRequired {
                    message = "Open MosaicNative.xcodeproj in Xcode and run MosaicNative → My Mac. MosaicDemo cannot unlock this protected vault."
                } else {
                    message = "Vault could not open (\(code)). No fallback store was created."
                }
                working = false
            }
        }
    }
    func lock() {
        epoch = UUID()
        let cancelledTask = task
        cancelledTask?.cancel()
        task = nil
        unlocked = false
        working = false
        captures = []
        selected = nil
        selectedImage = nil
        editing = false
        editText = ""
        query = ""
        searchResults = nil
        recoveryKeyText = ""
        restoreKeyText = ""
        recordedRecoveryKey = false
        let closing = session, cancelling = recoveryCustody, previous = locking
        let folder = scopedFolder
        scopedFolder = nil
        session = nil; recoveryCustody = nil
        message = "Locked. Content is hidden."
        locking = Task {
            await previous?.value
            await closing?.lock()
            await cancelling?.cancel()
            await cancelledTask?.value
            folder?.stopAccessingSecurityScopedResource()
        }
    }
    private func perform(_ operation: @escaping @MainActor (VaultSession) async throws -> Void) {
        guard unlocked, !working, let session else { return }
        let ticket = epoch
        working = true
        activity()
        task = Task {
            do {
                try await operation(session)
                guard epoch == ticket else { return }
                let loaded = try await session.page()
                guard epoch == ticket else { return }
                captures = loaded
                working = false
            } catch {
                guard epoch == ticket else { return }
                task = nil
                lock()
                message = "Operation stopped and vault locked. Changes may not have committed; unlock to inspect the durable state."
            }
        }
    }
    func select(_ id: UUID) {
        selected = id
        editing = false
        editText = ""
        selectedImage = nil
        perform { [weak self] session in
            let bytes = try await session.source(id)
            try Task.checkCancellation()
            guard let imageSource = CGImageSourceCreateWithData(bytes as CFData, nil),
                  let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else { throw SessionFailure.invalidConfiguration }
            self?.selectedImage = image
        }
    }
    /// Explicit synthetic-file capability only; no folder scanning or personal import.
    func chooseSyntheticImage() {
        guard unlocked, !working else { return }
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.png, .jpeg]
        panel.message = "Choose an image containing only invented test content. It will be saved encrypted in this vault. Do not choose personal images."
        guard panel.runModal() == .OK, let url = panel.url else { return }
        importSelectedFile(url)
    }
    func importSelectedFile(_ url: URL) {
        perform { [weak self] session in
            let scoped = url.startAccessingSecurityScopedResource()
            defer { if scoped { url.stopAccessingSecurityScopedResource() } }
            let worker = Task.detached {
                try Task.checkCancellation()
                let bytes = try BoundedImageImport.readSelectedFile(url)
                _ = try BoundedImageImport.decode(bytes)
                try Task.checkCancellation()
                return bytes
            }
            let bytes = try await withTaskCancellationHandler { try await worker.value } onCancel: { worker.cancel() }
            try Task.checkCancellation()
            let id = try await session.receive(bytes)
            try Task.checkCancellation()
            self?.selected = id
            self?.selectedImage = nil
            self?.editing = false
            self?.editText = ""
            self?.message = "Synthetic image saved in vault. Resume processing for local OCR; an exact duplicate reopens its existing record."
        }
    }
    func addSample() {
        perform { [weak self] session in
            let image = NSImage(size: NSSize(width: 1000, height: 240))
            image.lockFocus()
            NSColor.white.setFill()
            NSRect(x: 0, y: 0, width: 1000, height: 240).fill()
            ("MOSAIC SYNTHETIC TRAIN 1900" as NSString).draw(at: NSPoint(x: 60, y: 95),
                withAttributes: [.font: NSFont.systemFont(ofSize: 48), .foregroundColor: NSColor.black])
            image.unlockFocus()
            guard let pixels = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else { throw SessionFailure.invalidConfiguration }
            let bytes = NSMutableData()
            guard let destination = CGImageDestinationCreateWithData(bytes, UTType.png.identifier as CFString, 1, nil) else { throw SessionFailure.invalidConfiguration }
            CGImageDestinationAddImage(destination, pixels, nil)
            guard CGImageDestinationFinalize(destination) else { throw SessionFailure.invalidConfiguration }
            let id = try await session.receive(bytes as Data)
            try Task.checkCancellation()
            self?.selected = id
            self?.message = "Source receipt committed. Choose Resume processing for local OCR."
        }
    }
    func resume() {
        perform { [weak self] session in
            try await session.resumeProcessing()
            try Task.checkCancellation()
            self?.message = "Processing complete. Review the observation before approval."
        }
    }
    func search() {
        let term = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if term.isEmpty { searchResults = nil; return }
        perform { [weak self] session in
            let matches = try await session.search(term)
            try Task.checkCancellation()
            self?.searchResults = matches
            if let selected = self?.selected, !matches.contains(selected) {
                self?.selected = nil
                self?.selectedImage = nil
                self?.editing = false
                self?.editText = ""
            }
        }
    }
    func prepareRecoveryKey() {
        guard unlocked, !working else { return }
        var bytes = Data(count: 32)
        guard bytes.withUnsafeMutableBytes({ SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!) }) == errSecSuccess else {
            message = "Recovery material could not be generated."
            return
        }
        recoveryKeyText = bytes.map { String(format: "%02x", $0) }.joined()
        recordedRecoveryKey = false
        activity()
    }
    private func recoveryKey(_ text: String) throws -> Data {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard text.utf8.count == 64, text.allSatisfy({ $0.isASCII && $0.isHexDigit }) else { throw SessionFailure.invalidConfiguration }
        var bytes = Data()
        var index = text.startIndex
        for _ in 0..<32 {
            let next = text.index(index, offsetBy: 2)
            guard let byte = UInt8(text[index..<next], radix: 16) else { throw SessionFailure.invalidConfiguration }
            bytes.append(byte)
            index = next
        }
        return bytes
    }
    func backup() {
        guard recordedRecoveryKey, (try? recoveryKey(recoveryKeyText)) != nil, unlocked, !working else { return }
        let panel = NSSavePanel()
        panel.nameFieldStringValue = "Mosaic-synthetic-backup.sqlite"
        panel.message = "Save a synthetic encrypted backup. Existing files will not be replaced."
        guard panel.runModal() == .OK, let url = panel.url else { return }
        backupSelectedFile(url)
    }
    func backupSelectedFile(_ url: URL) {
        guard recordedRecoveryKey, let key = try? recoveryKey(recoveryKeyText), unlocked, !working else { return }
        perform { [weak self] session in
            let scoped = url.startAccessingSecurityScopedResource()
            defer { if scoped { url.stopAccessingSecurityScopedResource() } }
            try await session.snapshot(to: url, recoveryKey: key)
            try Task.checkCancellation()
            self?.recoveryKeyText = ""
            self?.recordedRecoveryKey = false
            self?.message = "Encrypted backup created. Keep its independent key separately."
        }
    }
    func restore() {
        guard !unlocked, !working, (try? recoveryKey(restoreKeyText)) != nil else { return }
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.message = "Select only a synthetic Mosaic backup made by this build."
        guard panel.runModal() == .OK, let snapshot = panel.url else { return }
        restoreSelectedBackup(snapshot)
    }
    func restoreSelectedBackup(_ snapshot: URL) {
        guard !unlocked, !working, let key = try? recoveryKey(restoreKeyText) else { return }
        working = true
        let ticket = epoch, profile = UUID(), precedingLock = locking
        let custody = custodyFactory()
        recoveryCustody = custody
        task = Task {
            let scoped = snapshot.startAccessingSecurityScopedResource()
            defer { if scoped { snapshot.stopAccessingSecurityScopedResource() } }
            do {
                try Task.checkCancellation()
                await precedingLock?.value
                try Task.checkCancellation()
                guard epoch == ticket else { return }
                try resolveVaultFolder()
                let destinationRoot = base.appendingPathComponent("restore-\(profile.uuidString)", isDirectory: true)
                guard destinationRoot.resolvingSymlinksInPath().path == destinationRoot.standardizedFileURL.path else { throw SessionFailure.invalidConfiguration }
                try FileManager.default.createDirectory(at: destinationRoot, withIntermediateDirectories: false)
                let destination = destinationRoot.appendingPathComponent("vault.sqlite")
                let identity = try await VaultSession.restore(snapshot: snapshot, recoveryKey: key, destination: destination, custody: custody)
                try Task.checkCancellation()
                guard ticket == epoch else { return }
                let metadata = Identity(vaultID: identity.vaultID, ownerID: identity.ownerID, setupComplete: true)
                try JSONEncoder().encode(metadata).write(to: destinationRoot.appendingPathComponent("identity.json"), options: .atomic)
                try Data(profile.uuidString.utf8).write(to: base.appendingPathComponent("active-profile.json"), options: .atomic)
                root = destinationRoot
                restoreKeyText = ""
                recoveryCustody = nil
                message = "Restored into a new profile. Unlock to inspect synthetic records."
                working = false
            } catch {
                guard epoch == ticket else { return }
                restoreKeyText = ""
                await custody.cancel()
                guard epoch == ticket else { return }
                let code: String
                if let failure = error as? VaultStorageFailure { code = String(describing: failure) }
                else if let failure = error as? SessionFailure { code = String(describing: failure) }
                else { code = "storageUnavailable" }
                message = "Restore failed (\(code)). Check recovery key/authentication/storage. Existing vault and backup were not replaced."
                working = false
            }
        }
    }
    func retry(_ record: StoredCapture) {
        perform { session in
            try await session.retry(record.id)
            try await session.resumeProcessing()
        }
    }
    func save(_ record: StoredCapture) {
        let text = editText
        perform { [weak self] session in
            try await session.save(record.id, text: text, revision: record.revision)
            try Task.checkCancellation()
            self?.editing = false
            self?.editText = ""
            self?.message = "Accepted text committed. Original source is unchanged."
        }
    }
    func discard(_ record: StoredCapture) {
        perform { [weak self] session in
            try await session.discard(record.id, revision: record.revision)
            try Task.checkCancellation()
            self?.selected = nil
            self?.selectedImage = nil
            self?.editing = false
            self?.editText = ""
            self?.message = "Record deleted from this vault."
        }
    }
}

struct ProtectedDemoView: View {
    @EnvironmentObject private var model: ProtectedDemoModel
    @State private var discardConfirmation = false
    @State private var destination: VaultWorkspaceTab = .inbox
    private var visibleCaptures: [StoredCapture] {
        let matches = model.query.isEmpty ? nil : model.searchResults.map(Set.init)
        return VaultWorkspace(captures: model.captures).visible(in: destination,
            unlocked: model.unlocked, matches: matches)
    }
    @Environment(\.scenePhase) private var phase
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Mosaic").font(.title2)
                Text("v0.1.1-rc.1 · Protected test build").font(.caption).foregroundStyle(.secondary)
                Spacer()
                Button { destination = .settings } label: { Image(systemName: "gearshape") }
                    .help("Settings").accessibilityLabel("Settings")
                if model.unlocked {
                    Button { model.lock() } label: { Image(systemName: "lock.fill") }
                        .help("Lock vault").accessibilityLabel("Lock vault")
                }
            }
            HStack {
                ForEach(VaultWorkspaceTab.allCases, id: \.self) { tab in
                    Button { destination = tab } label: {
                        Label(tab.rawValue, systemImage: tab == .inbox ? "tray" : tab == .library ? "square.grid.2x2" : tab == .settings ? "gearshape" : "magnifyingglass")
                    }.buttonStyle(.bordered)
                        .tint(destination == tab ? .accentColor : .secondary)
                        .accessibilityAddTraits(destination == tab ? .isSelected : [])
                }
                Spacer()
                Label(model.unlocked ? "Vault unlocked" : "Vault locked", systemImage: "lock.shield")
                    .font(.caption).foregroundStyle(.secondary)
            }
            if destination == .settings {
                ScrollView { ProtectedSettingsView() }
            } else if !model.unlocked {
                ContentUnavailableView("Vault locked", systemImage: "lock.shield",
                    description: Text("Unlock in Settings to see your saved content."))
                Button("Open Settings") { destination = .settings }
            } else {
                HStack {
                    Button { model.addSample() } label: { Image(systemName: "plus") }.help("Save synthetic sample")
                        .accessibilityLabel("Save synthetic sample")
                    Button { model.chooseSyntheticImage() } label: { Image(systemName: "photo.badge.plus") }
                        .help("Import invented PNG or JPEG…").accessibilityLabel("Import synthetic image")
                    Button { model.resume() } label: { Image(systemName: "play.fill") }.help("Resume saved processing")
                        .accessibilityLabel("Resume saved processing")
                    Spacer()
                    Text("\(model.captures.count) captures").font(.caption)
                }.disabled(model.working)
                if destination != .inbox {
                HStack {
                    TextField("Search accepted content · Return to search", text: $model.query)
                        .textFieldStyle(.roundedBorder).onSubmit { model.search() }
                    Button { model.search() } label: { Image(systemName: "magnifyingglass") }
                        .accessibilityLabel("Search accepted content").disabled(model.working)
                }
                }
                if visibleCaptures.isEmpty {
                    Text(destination == .search ? "Enter a term and search your accepted records." : destination == .library ? "Approved records appear here." : "No records need review.")
                        .foregroundStyle(.secondary)
                }
                HSplitView {
                    List(visibleCaptures, id: \.id) { capture in
                        Button { model.select(capture.id) } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "lock.shield").font(.caption)
                                        .help("Stored in your vault").accessibilityLabel("Stored in vault")
                                    Text(capture.acceptedText ?? (capture.needsProcessing ? "Saved capture" : capture.observation.isEmpty ? "No text recognized" : capture.observation))
                                    .lineLimit(3)
                                }
                                Text(capture.retryRequired ? "Retry required" : capture.needsProcessing ? "Waiting for processing" : capture.acceptedText == nil ? "Needs review" : "Accepted")
                                    .font(.caption).foregroundStyle(.secondary)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }.buttonStyle(.plain).disabled(model.working)
                    }.frame(minWidth: 220)
                    ScrollView {
                        if let capture = visibleCaptures.first(where: { $0.id == model.selected }) {
                            VStack(alignment: .leading, spacing: 16) {
                                Label("Stored in vault", systemImage: "lock.shield")
                                    .font(.caption).foregroundStyle(.secondary)
                                Text(capture.acceptedText ?? capture.observation).textSelection(.enabled)
                                if let image = model.selectedImage {
                                    Image(decorative: image, scale: 1).resizable().scaledToFit().frame(maxHeight: 240)
                                }
                                HStack {
                                    if capture.retryRequired {
                                        Button { model.retry(capture) } label: { Image(systemName: "arrow.clockwise") }
                                            .help("Retry processing").accessibilityLabel("Retry processing")
                                    }
                                    if !capture.needsProcessing {
                                        Button {
                                            model.editText = capture.acceptedText ?? capture.observation
                                            model.editing = true
                                        } label: { Image(systemName: "pencil") }
                                        .help(capture.acceptedText == nil ? "Review and approve" : "Edit accepted text")
                                        .accessibilityLabel("Edit or approve selected text")
                                    }
                                    Button(role: .destructive) { discardConfirmation = true } label: { Image(systemName: "trash") }
                                        .help("Delete selected record").accessibilityLabel("Delete selected record")
                                }.disabled(model.working)
                                if model.editing {
                                    TextEditor(text: $model.editText).frame(height: 140)
                                    HStack {
                                        Button("Cancel") { model.editing = false; model.editText = "" }
                                        Button(capture.acceptedText == nil ? "Approve" : "Save") { model.save(capture) }
                                            .disabled(model.editText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || model.working)
                                    }
                                }
                            }.padding()
                        }
                    }.frame(minWidth: 320)
                }
            }
            Divider()
            HStack {
                Text("Invented test images only · Edits and search share this protected collection.")
                    .font(.caption).foregroundStyle(.secondary)
            }
            // TODO(MOS-016/018/020): collections, semantic search and rediscovery remain unavailable.
            if model.working { ProgressView("Working locally…") }
            Text(model.message).font(.callout).foregroundStyle(.secondary)
        }
        .padding(24).frame(minWidth: 900, minHeight: 640)
        .confirmationDialog("Delete this synthetic record?", isPresented: $discardConfirmation) {
            Button("Delete", role: .destructive) {
                if let capture = model.captures.first(where: { $0.id == model.selected }) { model.discard(capture) }
            }
        }
        .onReceive(Timer.publish(every: 30, on: .main, in: .common).autoconnect()) { _ in model.checkIdle() }
        .onChange(of: destination) {
            model.selected = nil; model.selectedImage = nil; model.editing = false; model.editText = ""
            discardConfirmation = false
        }
        .onChange(of: model.unlocked) { if !model.unlocked { discardConfirmation = false } }
        .onChange(of: model.editText) { model.activity() }
        .onChange(of: model.query) { model.activity(); if model.query.isEmpty { model.searchResults = nil } }
        .onChange(of: phase) { if phase == .background { model.lock() } }
        .onReceive(NSWorkspace.shared.notificationCenter.publisher(for: NSWorkspace.sessionDidResignActiveNotification)) { _ in model.lock() }
        .onDisappear { model.lock() }
    }
}

struct ProtectedSettingsView: View {
    @EnvironmentObject private var model: ProtectedDemoModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings").font(.title2)
            GroupBox {
                VStack(alignment: .leading, spacing: 12) {
                    Label("Vault protection", systemImage: "lock.shield").font(.headline)
                    Text("Your saved content opens after Mac authentication. Locking hides it without deleting it.")
                    if model.unlocked {
                        Button("Lock vault") { model.lock() }
                    } else {
                        Button("Unlock vault") { model.open() }.disabled(model.working)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            Text("Backup & recovery").font(.headline)
            Text("Test build: use generated samples only. Keep recovery keys private and separate from backups.")
                .font(.caption).foregroundStyle(.secondary)
            if model.unlocked {
                Button("Generate independent recovery key") { model.prepareRecoveryKey() }.disabled(model.working)
                if !model.recoveryKeyText.isEmpty {
                    Text(model.recoveryKeyText).font(.system(.body, design: .monospaced)).textSelection(.enabled)
                    Toggle("I recorded this key separately from the backup", isOn: $model.recordedRecoveryKey)
                    Button("Create encrypted backup…") { model.backup() }.disabled(!model.recordedRecoveryKey || model.working)
                }
                Button("Lock before restoring") { model.lock() }
            } else {
                SecureField("64-character recovery key", text: $model.restoreKeyText)
                Button("Choose synthetic backup and restore to a new profile…") { model.restore() }
                    .disabled(model.restoreKeyText.trimmingCharacters(in: .whitespacesAndNewlines).count != 64 || model.working)
            }
            if model.working { ProgressView() }
            Text(model.message).font(.callout).foregroundStyle(.secondary)
            GroupBox("Storage location") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Choose an existing synthetic-vault folder while locked. No content is moved and unavailable storage never opens a fallback collection.")
                    Button("Choose vault folder…") { model.chooseVaultFolder() }.disabled(model.unlocked || model.working)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }.padding(16).frame(maxWidth: .infinity, alignment: .leading)
        .onDisappear { model.recoveryKeyText = ""; model.restoreKeyText = ""; model.recordedRecoveryKey = false }
    }
}
#endif
