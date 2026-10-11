#if canImport(CoreGraphics)
import CoreGraphics
import CryptoKit
import Foundation

/// Session-only identity from decoded pixels, never from filenames or OCR text.
public enum ImageFingerprint {
    public enum Failure: Error { case renderingFailed }

    public static func make(_ image: CGImage) throws -> String {
        try BoundedImageImport.validateDimensions(width: image.width, height: image.height)
        guard let context = CGContext(
            data: nil, width: image.width, height: image.height,
            bitsPerComponent: 8, bytesPerRow: 0,
            space: CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
              let bytes = context.data else { throw Failure.renderingFailed }
        context.setBlendMode(.copy)
        context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        var hash = SHA256()
        hash.update(data: Data("\(image.width)x\(image.height):".utf8))
        for row in 0..<image.height {
            hash.update(data: Data(bytes: bytes.advanced(by: row * context.bytesPerRow),
                                   count: image.width * 4))
        }
        return hash.finalize().map { String(format: "%02x", $0) }.joined()
    }
}
#endif
