#if os(macOS)
import AppKit
import SwiftUI

/// Native adaptation of docs/design/VISUAL-SYSTEM.md.
/// Dark appearance uses system surfaces until the custom dark palette is validated.
enum MosaicStyle {
    static let canvas = adaptive(0xF8F9F5, dark: .windowBackgroundColor)
    static let sidebar = adaptive(0xF0F2EB, dark: .controlBackgroundColor)
    static let card = adaptive(0xFFFFFF, dark: .controlBackgroundColor)
    static let ink = adaptive(0x2E4333, dark: .labelColor)
    // Darkened from the POC metadata token for readable text on light surfaces.
    static let secondaryInk = adaptive(0x586550, dark: .secondaryLabelColor)
    static let accent = adaptive(0x365A42, dark: .controlAccentColor)
    static let selection = adaptive(0xE0E8D9, dark: .selectedContentBackgroundColor)
    static let radius: CGFloat = 12
    static let gap: CGFloat = 16
    static let inset: CGFloat = 24

    private static func adaptive(_ hex: UInt32, dark: NSColor) -> Color {
        Color(nsColor: NSColor(name: nil) { appearance in
            if appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua { return dark }
            return NSColor(srgbRed: Double((hex >> 16) & 255) / 255,
                           green: Double((hex >> 8) & 255) / 255,
                           blue: Double(hex & 255) / 255, alpha: 1)
        })
    }
}

/// TODO(MOS-016/018/020/023/024): replace each placeholder only after its
/// scoped service works. These labels are capability disclosure, not task status.
struct PlannedControl: View {
    let title: String
    let symbol: String
    let reason: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button {} label: {
                HStack {
                    Label(title, systemImage: symbol)
                    Spacer()
                    Text("Planned").font(.caption)
                }
            }
            .buttonStyle(.plain)
            .disabled(true)
            Text(reason).font(.caption).foregroundStyle(MosaicStyle.secondaryInk)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), planned, unavailable. \(reason)")
        .help(reason)
    }
}
#endif
