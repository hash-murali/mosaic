import Foundation
import CoreGraphics
import ImageIO

/// Conservative foreground budgets; not a durable import receipt.
public enum BoundedImageImport {
    public static let maximumFileBytes = 25 * 1024 * 1024
    public static let maximumPixels = 30_000_000
    public static let maximumSessionBytes = 256 * 1024 * 1024
    public static let maximumSessionRecords = 32

    public enum Failure: Error, Equatable {
        case tooLarge, invalidImage, unsupportedFormat, sessionFull
    }

    public static func validateDimensions(width: Int, height: Int) throws {
        guard width > 0, height > 0 else { throw Failure.invalidImage }
        let (pixels, overflow) = width.multipliedReportingOverflow(by: height)
        guard !overflow, pixels <= maximumPixels else { throw Failure.tooLarge }
    }

    /// Caller supplies only an explicitly selected file capability. No scanning.
    public static func readSelectedFile(_ url: URL) throws -> Data {
        try Task.checkCancellation()
        let handle = try FileHandle(forReadingFrom: url)
        defer { try? handle.close() }
        var bytes = Data()
        while let chunk = try handle.read(upToCount: min(64 * 1024, maximumFileBytes + 1 - bytes.count)),
              !chunk.isEmpty {
            try Task.checkCancellation()
            bytes.append(chunk)
            guard bytes.count <= maximumFileBytes else { throw Failure.tooLarge }
        }
        return bytes
    }

    /// Header limits precede decoding. Normalize EXIF orientation locally.
    public static func decode(_ bytes: Data) throws -> CGImage {
        guard bytes.count <= maximumFileBytes else { throw Failure.tooLarge }
        guard let source = CGImageSourceCreateWithData(bytes as CFData,
            [kCGImageSourceShouldCache: false] as CFDictionary),
              CGImageSourceGetCount(source) == 1,
              let type = CGImageSourceGetType(source) as String? else {
            throw Failure.invalidImage
        }
        // TODO(MOS-002/009): enable HEIC/TIFF only after format/orientation fixtures pass.
        guard ["public.png", "public.jpeg"].contains(type) else { throw Failure.unsupportedFormat }
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any],
              let width = properties[kCGImagePropertyPixelWidth] as? Int,
              let height = properties[kCGImagePropertyPixelHeight] as? Int else {
            throw Failure.invalidImage
        }
        try validateDimensions(width: width, height: height)
        guard let image = CGImageSourceCreateThumbnailAtIndex(source, 0, [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: max(width, height),
            kCGImageSourceShouldCacheImmediately: true
        ] as CFDictionary) else { throw Failure.invalidImage }
        try validateDimensions(width: image.width, height: image.height)
        return image
    }

    public static func validateSession(additionalBytes: Int, retainedBytes: Int,
                                       recordCount: Int) throws {
        guard additionalBytes >= 0, retainedBytes >= 0, recordCount >= 0 else {
            throw Failure.invalidImage
        }
        let (total, overflow) = retainedBytes.addingReportingOverflow(additionalBytes)
        guard !overflow, total <= maximumSessionBytes,
              recordCount < maximumSessionRecords else { throw Failure.sessionFull }
    }
}
