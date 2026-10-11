import Foundation
import MosaicStorage

public enum VaultWorkspaceTab: String, CaseIterable, Sendable {
    case inbox = "Inbox", library = "Library", search = "Search", settings = "Settings"
}

/// Shared presentation of authorized service results. Not an authority or store.
/// Even a retained projection yields no records after the UI is locked.
public struct VaultWorkspace: Sendable {
    private let captures: [StoredCapture]
    public init(captures: [StoredCapture]) { self.captures = captures }
    public func visible(in tab: VaultWorkspaceTab, unlocked: Bool,
                        matches: Set<UUID>? = nil) -> [StoredCapture] {
        guard unlocked else { return [] }
        switch tab {
        case .settings: return []
        case .inbox: return captures.filter { $0.acceptedText == nil }
        case .library:
            return captures.filter { $0.acceptedText != nil && (matches == nil || matches!.contains($0.id)) }
        case .search:
            guard let matches else { return [] }
            return captures.filter { $0.acceptedText != nil && matches.contains($0.id) }
        }
    }
}
