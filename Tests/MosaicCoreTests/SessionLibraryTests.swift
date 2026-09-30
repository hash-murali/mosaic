import Testing
@testable import MosaicCore

@Test func newImportsPreserveApprovedRecordsAndPendingReviews() {
    var library = SessionLibrary()
    let first = Record(observation: .init(text: "Synthetic train 1900"))
    let second = Record(observation: .init(text: "Synthetic ferry 2100"))
    let third = Record(observation: .init(text: "Synthetic cafe 0800"))
    library.add(first)
    library.review(first.id)
    library.add(second)
    library.add(third)
    #expect(library.search("train").map(\.id) == [first.id])
    #expect(library.search("ferry").isEmpty)
    #expect(library.pending.map(\.id) == [second.id, third.id])
    library.review(second.id, correction: .init(text: "Synthetic ferry 2200"))
    #expect(library.search("2200").map(\.id) == [second.id])
    #expect(library.search("2100").isEmpty)
    #expect(library.records[1].observation == second.observation)
    library.discard(third.id)
    #expect(library.pending.isEmpty)
    #expect(library.search("train").map(\.id) == [first.id])
    #expect(library.search("ferry").map(\.id) == [second.id])
}
