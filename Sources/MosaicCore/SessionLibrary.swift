import Foundation

/// Session-only records; pending items remain available without entering search.
public struct SessionLibrary: Sendable {
    public private(set) var records: [Record] = []
    public init() {}
    public var pending: [Record] { records.filter { $0.reviewState == .pending } }
    public mutating func add(_ record: Record) {
        guard !records.contains(where: { $0.id == record.id }) else { return }
        records.append(record)
    }
    public mutating func review(_ id: UUID, correction: UserCorrection? = nil) {
        guard let index = records.firstIndex(where: { $0.id == id }) else { return }
        records[index].review(correction: correction)
    }
    public mutating func discard(_ id: UUID) { records.removeAll { $0.id == id } }
    public func search(_ query: String) -> [Record] {
        LocalSearch.search(query, in: records)
    }
}
