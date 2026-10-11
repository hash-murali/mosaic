import Foundation

/// An unfinished edit is separate from both OCR observations and approved text.
public struct ReviewDraft: Sendable, Equatable {
    public var text: String
    public var usesCorrection: Bool
    public init(text: String, usesCorrection: Bool = false) {
        self.text = text
        self.usesCorrection = usesCorrection
    }
}

/// Session-only records; pending items remain available without entering search.
public struct SessionLibrary: Sendable {
    public private(set) var records: [Record] = []
    private var drafts: [UUID: ReviewDraft] = [:]
    private var approvedEdits: [UUID: ReviewDraft] = [:]
    private var sourceFingerprints: [UUID: String] = [:]
    public init() {}
    public var pending: [Record] { records.filter { $0.reviewState == .pending } }
    public func record(forSourceFingerprint fingerprint: String) -> Record? {
        records.first { sourceFingerprints[$0.id] == fingerprint }
    }
    @discardableResult
    public mutating func add(_ record: Record, sourceFingerprint: String? = nil) -> UUID {
        if let sourceFingerprint,
           let existing = self.record(forSourceFingerprint: sourceFingerprint) {
            return existing.id
        }
        guard !records.contains(where: { $0.id == record.id }) else { return record.id }
        records.append(record)
        sourceFingerprints[record.id] = sourceFingerprint
        return record.id
    }
    @discardableResult
    public mutating func review(_ id: UUID, correction: UserCorrection? = nil) -> Bool {
        guard let index = records.firstIndex(where: { $0.id == id }),
              !(correction?.text ?? records[index].observation.text)
                .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        records[index].review(correction: correction)
        drafts.removeValue(forKey: id)
        approvedEdits.removeValue(forKey: id)
        return true
    }
    public func draft(for id: UUID) -> ReviewDraft? {
        guard let record = records.first(where: { $0.id == id }),
              record.reviewState == .pending else { return nil }
        return drafts[id] ?? ReviewDraft(text: record.observation.text)
    }
    public mutating func updateDraft(_ draft: ReviewDraft, for id: UUID) {
        guard records.contains(where: { $0.id == id && $0.reviewState == .pending }) else { return }
        drafts[id] = draft
    }
    public func canApproveDraft(for id: UUID) -> Bool {
        guard let draft = draft(for: id),
              let record = records.first(where: { $0.id == id }) else { return false }
        return !(draft.usesCorrection ? draft.text : record.observation.text)
            .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    @discardableResult
    public mutating func approveDraft(for id: UUID) -> Bool {
        guard let draft = draft(for: id) else { return false }
        return review(id, correction: draft.usesCorrection ? .init(text: draft.text) : nil)
    }
    public mutating func discard(_ id: UUID) {
        records.removeAll { $0.id == id }
        drafts.removeValue(forKey: id)
        approvedEdits.removeValue(forKey: id)
        sourceFingerprints.removeValue(forKey: id)
    }
    public func search(_ query: String) -> [Record] {
        LocalSearch.search(query, in: records)
    }

    /// Explicit edit mode; accepted text remains searchable until Save succeeds.
    public mutating func beginApprovedEdit(for id: UUID) {
        guard let record = records.first(where: { $0.id == id && $0.reviewState == .reviewed }),
              approvedEdits[id] == nil else { return }
        approvedEdits[id] = ReviewDraft(text: record.reviewedText ?? "", usesCorrection: true)
    }
    public func approvedEdit(for id: UUID) -> ReviewDraft? { approvedEdits[id] }
    public mutating func updateApprovedEdit(_ draft: ReviewDraft, for id: UUID) {
        guard approvedEdits[id] != nil else { return }
        approvedEdits[id] = draft
    }
    public mutating func cancelApprovedEdit(for id: UUID) { approvedEdits.removeValue(forKey: id) }
    public func canSaveApprovedEdit(for id: UUID) -> Bool {
        guard let draft = approvedEdits[id],
              let record = records.first(where: { $0.id == id && $0.reviewState == .reviewed }) else { return false }
        return !(draft.usesCorrection ? draft.text : record.observation.text)
            .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    @discardableResult
    public mutating func saveApprovedEdit(for id: UUID) -> Bool {
        guard canSaveApprovedEdit(for: id), let draft = approvedEdits[id] else { return false }
        return review(id, correction: draft.usesCorrection ? .init(text: draft.text) : nil)
    }
}
