import Foundation

/// In-memory search only; no persistence, network, providers, or telemetry.
public enum LocalSearch {
    public static func search(_ query: String, in records: [Record]) -> [Record] {
        let terms = query.split(whereSeparator: { $0.isWhitespace }).map(String.init)
        guard !terms.isEmpty else { return [] }
        return records.filter { record in
            guard let text = record.reviewedText else { return false }
            return terms.allSatisfy { term in
                text.range(of: term, options: [.caseInsensitive, .diacriticInsensitive],
                           locale: Locale(identifier: "en_US_POSIX")) != nil
            }
        }
    }
}
