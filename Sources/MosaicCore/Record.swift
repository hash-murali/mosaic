import Foundation

/// Text from an import is data only. This layer never opens URLs or executes text.
public struct SourceObservation: Equatable, Sendable {
    public let text: String

    public init(text: String) { self.text = text }
}

public struct ModelInference: Equatable, Sendable {
    public let label: String

    public init(label: String) { self.label = label }
}

public struct UserCorrection: Equatable, Sendable {
    public let text: String

    public init(text: String) { self.text = text }
}

public struct Record: Identifiable, Equatable, Sendable {
    public enum ReviewState: Equatable, Sendable {
        case pending
        case reviewed
    }

    public let id: UUID
    public let observation: SourceObservation
    public let inferences: [ModelInference]
    public private(set) var correction: UserCorrection?
    public private(set) var reviewState: ReviewState = .pending

    public init(
        id: UUID = UUID(),
        observation: SourceObservation,
        inferences: [ModelInference] = []
    ) {
        self.id = id
        self.observation = observation
        self.inferences = inferences
    }

    public mutating func review(correction: UserCorrection? = nil) {
        self.correction = correction
        reviewState = .reviewed
    }

    /// An explicit correction replaces the searchable text, preserving the source.
    public var reviewedText: String? {
        guard reviewState == .reviewed else { return nil }
        return correction?.text ?? observation.text
    }
}
