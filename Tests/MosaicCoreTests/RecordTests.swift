import Testing
@testable import MosaicCore

@Test func pendingRecordsAreExcluded() {
    let record = Record(observation: .init(text: "Synthetic café booking"))
    #expect(LocalSearch.search("booking", in: [record]).isEmpty)
}

@Test func reviewPreservesProvenanceAndSearchesCorrection() {
    var record = Record(observation: .init(text: "Synthetic train 18:00"),
                        inferences: [.init(label: "Travel")])
    record.review(correction: .init(text: "Synthetic train 19:00"))
    #expect(record.observation.text == "Synthetic train 18:00")
    #expect(record.inferences == [.init(label: "Travel")])
    #expect(LocalSearch.search("18:00", in: [record]).isEmpty)
    #expect(LocalSearch.search("TRAIN 19:00", in: [record]) == [record])
    #expect(LocalSearch.search("Travel", in: [record]).isEmpty)
}

@Test func searchHandlesWhitespaceAccentsAndAllTerms() {
    var record = Record(observation: .init(text: "Synthetic café booking"))
    record.review()
    #expect(LocalSearch.search("  CAFE booking  ", in: [record]) == [record])
    #expect(LocalSearch.search("cafe missing", in: [record]).isEmpty)
    #expect(LocalSearch.search(" \n ", in: [record]).isEmpty)
}

@Test func emptyCorrectionDoesNotRestoreSource() {
    var record = Record(observation: .init(text: "Synthetic unwanted text"))
    record.review(correction: .init(text: ""))
    #expect(record.reviewedText == "")
    #expect(LocalSearch.search("unwanted", in: [record]).isEmpty)
}
