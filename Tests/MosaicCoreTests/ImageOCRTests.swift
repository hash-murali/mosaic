#if os(macOS)
import AppKit
import Testing
@testable import MosaicCore

/// Generates fixture pixels in memory; no screenshot or file input is used.
@MainActor
private func syntheticImage(text: String) throws -> CGImage {
    let image = NSImage(size: NSSize(width: 1000, height: 240))
    image.lockFocus()
    NSColor.white.setFill()
    NSRect(x: 0, y: 0, width: 1000, height: 240).fill()
    (text as NSString).draw(
        at: NSPoint(x: 60, y: 95),
        withAttributes: [
            .font: NSFont.systemFont(ofSize: 48),
            .foregroundColor: NSColor.black
        ]
    )
    image.unlockFocus()
    return try #require(image.cgImage(forProposedRect: nil, context: nil, hints: nil))
}

@Test @MainActor
func syntheticOCRRequiresReviewBeforeSearch() throws {
    let image = try syntheticImage(text: "MOSAIC SYNTHETIC TRAIN 1900")
    let observation = try ImageOCR.recognize(image)
    #expect(observation.text.contains("MOSAIC"))
    #expect(observation.text.contains("1900"))
    var record = Record(observation: observation)
    #expect(LocalSearch.search("train", in: [record]).isEmpty)
    record.review()
    #expect(LocalSearch.search("train 1900", in: [record]) == [record])
}

@Test @MainActor
func blankSyntheticImageHasNoRecognizedText() throws {
    let observation = try ImageOCR.recognize(syntheticImage(text: ""))
    #expect(observation.text.isEmpty)
}
#endif
