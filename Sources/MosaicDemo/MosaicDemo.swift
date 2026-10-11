#if os(macOS)
import AppKit
import SwiftUI

@main
struct MosaicDemo: App {
    @NSApplicationDelegateAdaptor(DemoAppDelegate.self) private var appDelegate
    @StateObject private var model = ProtectedDemoModel()
    var body: some Scene {
        Window("Mosaic", id: "mosaic") {
            ProtectedDemoView().environmentObject(model)
        }
    }
}

@MainActor
private final class DemoAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.setActivationPolicy(.regular)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}
#else
@main enum MosaicDemo {
    static func main() { print("Mosaic currently requires macOS.") }
}
#endif
