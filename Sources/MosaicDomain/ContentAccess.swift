import Foundation

/// Opaque identities are distinct types to prevent mixing policy boundaries.
public struct VaultID: Hashable, Sendable {
    public let rawValue: UUID
    public init(_ rawValue: UUID) { self.rawValue = rawValue }
}

public struct PrincipalID: Hashable, Sendable {
    public let rawValue: UUID
    public init(_ rawValue: UUID) { self.rawValue = rawValue }
}

public struct ContentRecordID: Hashable, Sendable {
    public let rawValue: UUID
    public init(_ rawValue: UUID) { self.rawValue = rawValue }
}

public enum ContentOperation: Hashable, Sendable {
    case read, search, correct, delete, process, capture, backup
}

public enum ContentField: Hashable, Sendable {
    case source, observation, title, category, correction, processingState
}

/// Initial owner-only operations; portability will need separate destination consent.
public enum AccessPurpose: Hashable, Sendable {
    case ownerReview, ownerSearch, ownerProcessing, ownerCapture, ownerBackup
}

public enum AccessFailure: Error, Equatable, Sendable {
    case locked, permissionDenied, grantExpired, invalidInput
}

/// Explicit record/field scope. Search must enumerate authorized candidate IDs;
/// this type never implies authority over all records in a vault.
public struct ContentAccessRequest: Equatable, Sendable {
    public let vaultID: VaultID
    public let operation: ContentOperation
    public let purpose: AccessPurpose
    public let records: Set<ContentRecordID>
    public let fields: Set<ContentField>

    public init(vaultID: VaultID, operation: ContentOperation, purpose: AccessPurpose,
                records: Set<ContentRecordID>, fields: Set<ContentField>) throws {
        guard !records.isEmpty, !fields.isEmpty else { throw AccessFailure.invalidInput }
        let validPurpose: Bool
        switch operation {
        case .search: validPurpose = purpose == .ownerSearch
        case .process: validPurpose = purpose == .ownerProcessing
        case .backup: validPurpose = purpose == .ownerBackup
        case .capture: validPurpose = purpose == .ownerCapture
        case .read, .correct, .delete: validPurpose = purpose == .ownerReview
        }
        guard validPurpose else { throw AccessFailure.invalidInput }
        self.vaultID = vaultID
        self.operation = operation
        self.purpose = purpose
        self.records = records
        self.fields = fields
    }
}
