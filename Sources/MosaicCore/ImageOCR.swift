import CoreGraphics
import ImageIO
import Vision

/// Recognizes caller-supplied pixels locally. Does not read files or access Photos.
public enum ImageOCR {
    public static func recognize(
        _ image: CGImage,
        orientation: CGImagePropertyOrientation = .up
    ) throws -> SourceObservation {
        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en-US"]
        request.usesLanguageCorrection = false
        let handler = VNImageRequestHandler(cgImage: image, orientation: orientation)
        try handler.perform([request])
        let text = (request.results ?? []).compactMap {
            $0.topCandidates(1).first?.string
        }.joined(separator: "\n")
        return SourceObservation(text: text)
    }
}
