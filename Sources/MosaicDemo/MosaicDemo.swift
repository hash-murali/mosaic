#if os(macOS)
import AppKit
import SwiftUI
import MosaicCore
import UniformTypeIdentifiers

@main
struct MosaicDemo: App {
    @NSApplicationDelegateAdaptor(DemoAppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup("Mosaic — Local Demo") {
            DemoView().frame(minWidth: 720, minHeight: 580)
        }
    }
}

@MainActor
private final class DemoAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Swift-package executables need regular app activation for keyboard input.
        NSApplication.shared.setActivationPolicy(.regular)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}

private enum DemoError: Error { case imageCreationFailed }

/// Only this fixed, generated fixture is available in the demo.
@MainActor
private func makeFixture() throws -> CGImage {
    let image = NSImage(size: NSSize(width: 1000, height: 240))
    image.lockFocus()
    NSColor.white.setFill()
    NSRect(x: 0, y: 0, width: 1000, height: 240).fill()
    ("MOSAIC SYNTHETIC TRAIN 1900" as NSString).draw(
        at: NSPoint(x: 60, y: 95),
        withAttributes: [.font: NSFont.systemFont(ofSize: 48),
                         .foregroundColor: NSColor.black]
    )
    image.unlockFocus()
    guard let pixels = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
    else { throw DemoError.imageCreationFailed }
    return pixels
}

private struct DemoView: View {
    @State private var library = SessionLibrary()
    @State private var selectedID: UUID?
    @State private var images: [UUID: CGImage] = [:]
    private var record: Record? { library.records.first { $0.id == selectedID } }
    @State private var fixture: CGImage?
    @State private var correction = ""
    @State private var useCorrection = false
    @State private var query = "train"
    @State private var busy = false
    @State private var status = "Load the synthetic sample to begin."
    @FocusState private var searchFocused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Mosaic · v0.1.0 — Session Review").font(.largeTitle.bold())
                Text("Local demo • English OCR • Records stay in memory")
                    .foregroundStyle(.secondary)
                Button(busy ? "Recognizing…" : "Load synthetic sample") {
                    recognizeSample()
                }.disabled(busy)
                Button("Choose test image…") { chooseImage() }.disabled(busy)
                Button("Discard selected record") {
                    if let selectedID {
                        library.discard(selectedID)
                        images.removeValue(forKey: selectedID)
                    }
                    fixture = nil
                    selectedID = nil
                    correction = ""
                    useCorrection = false
                    query = ""
                    status = "Image and record cleared from the demo."
                }.disabled(busy || fixture == nil)
                Text(status).accessibilityIdentifier("demoStatus")
                Text("Review Inbox (\(library.pending.count))").font(.headline)
                if library.pending.isEmpty { Text("No records waiting for review.") }
                ForEach(library.pending) { item in
                    Button(item.observation.text.isEmpty ? "Image with no recognized text" : String(item.observation.text.prefix(80))) {
                        select(item)
                    }.disabled(busy)
                }
                Text("Approved library (\(library.records.count - library.pending.count))").font(.headline)
                ForEach(library.records.filter { $0.reviewState == .reviewed }) { item in
                    Button(String((item.reviewedText ?? "").prefix(80)).isEmpty ? "Empty reviewed record" : String((item.reviewedText ?? "").prefix(80))) {
                        select(item)
                    }.disabled(busy)
                }
                if let fixture {
                    Image(decorative: fixture, scale: 1)
                        .resizable().scaledToFit().frame(maxHeight: 160)
                        .accessibilityLabel("Loaded test image")
                }
                if let record {
                    Text("Original OCR observation").font(.headline)
                    Text(record.observation.text.isEmpty ? "No text recognized." : record.observation.text)
                        .textSelection(.enabled)
                    Toggle("Use my corrected text", isOn: $useCorrection)
                        .disabled(record.reviewState == .reviewed)
                    if useCorrection {
                        TextEditor(text: $correction).frame(height: 80)
                            .border(.secondary)
                            .disabled(record.reviewState == .reviewed)
                            .accessibilityLabel("Corrected text")
                    }
                    Button(record.reviewState == .reviewed ? "Reviewed" : "Approve record") {
                        library.review(record.id, correction: useCorrection ? .init(text: correction) : nil)
                        status = "Record reviewed. It is now available in search."
                        searchFocused = true
                    }.disabled(record.reviewState == .reviewed || busy)
                }
                Divider()
                Text("Search reviewed records").font(.headline)
                TextField("Search text", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($searchFocused)
                    .accessibilityIdentifier("searchField")
                if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text("Enter a search term.").foregroundStyle(.secondary)
                } else if library.search(query).isEmpty {
                    Text("No reviewed matches.").foregroundStyle(.secondary)
                } else {
                    ForEach(library.search(query)) { match in
                        VStack(alignment: .leading) {
                            Text(match.reviewedText ?? "").textSelection(.enabled)
                            Button("Open record") { select(match) }.disabled(busy)
                        }
                    }
                }
                Text("Choose only images you authorize for this local test. Each load adds a record. Closing the app discards the entire session. Share only synthetic examples in bug reports.")
                    .font(.caption).foregroundStyle(.secondary)
            }.padding(24)
        }
    }

    @MainActor private func select(_ item: Record) {
        selectedID = item.id
        fixture = images[item.id]
        useCorrection = item.correction != nil
        correction = item.correction?.text ?? item.observation.text
    }

    @MainActor private func recognizeSample() {
        do { recognize(try makeFixture(), initialQuery: "train") }
        catch { status = "Could not create the sample image." }
    }

    @MainActor private func chooseImage() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.png, .jpeg, .heic, .tiff]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.message = "Select one image you authorize for local OCR testing. It will not be saved by Mosaic."
        guard panel.runModal() == .OK, let url = panel.url else { return }
        let access = url.startAccessingSecurityScopedResource()
        defer { if access { url.stopAccessingSecurityScopedResource() } }
        guard let image = NSImage(contentsOf: url),
              let pixels = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        else {
            status = "Could not decode that image. Try a PNG or JPEG."
            return
        }
        recognize(pixels)
    }

    @MainActor private func recognize(_ pixels: CGImage, initialQuery: String = "") {
        busy = true
        selectedID = nil
        useCorrection = false
        correction = ""
        query = initialQuery
        searchFocused = false
        fixture = pixels
        status = "Recognizing the image locally…"
        Task {
            do {
                let observation = try await Task.detached {
                    try ImageOCR.recognize(pixels)
                }.value
                let added = Record(observation: observation)
                library.add(added)
                images[added.id] = pixels
                select(added)
                status = "OCR complete. Review the text before approving."
            } catch {
                status = "Recognition failed. Try a different image or the synthetic sample."
            }
            busy = false
        }
    }
}
#else
@main
enum MosaicDemo {
    static func main() { print("MosaicDemo currently requires macOS.") }
}
#endif
