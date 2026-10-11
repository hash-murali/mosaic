import Foundation
import Testing
@testable import MosaicCore

@Test func imageHeaderBudgetsRejectOverflowAndInvalidDimensions() throws {
    try BoundedImageImport.validateDimensions(width: 6000, height: 5000)
    #expect(throws: BoundedImageImport.Failure.tooLarge) {
        try BoundedImageImport.validateDimensions(width: 6000, height: 5001)
    }
    #expect(throws: BoundedImageImport.Failure.tooLarge) {
        try BoundedImageImport.validateDimensions(width: Int.max, height: 2)
    }
    #expect(throws: BoundedImageImport.Failure.invalidImage) {
        try BoundedImageImport.validateDimensions(width: 0, height: 10)
    }
    #expect(throws: BoundedImageImport.Failure.invalidImage) {
        try BoundedImageImport.decode(Data("SYNTHETIC NOT AN IMAGE".utf8))
    }
}

@Test func sessionBudgetRejectsExcessAndOverflowWithoutMutation() throws {
    try BoundedImageImport.validateSession(additionalBytes: 1, retainedBytes: 0, recordCount: 0)
    #expect(throws: BoundedImageImport.Failure.sessionFull) {
        try BoundedImageImport.validateSession(additionalBytes: 1,
            retainedBytes: BoundedImageImport.maximumSessionBytes, recordCount: 0)
    }
    #expect(throws: BoundedImageImport.Failure.sessionFull) {
        try BoundedImageImport.validateSession(additionalBytes: 1, retainedBytes: 0,
            recordCount: BoundedImageImport.maximumSessionRecords)
    }
    #expect(throws: BoundedImageImport.Failure.sessionFull) {
        try BoundedImageImport.validateSession(additionalBytes: Int.max,
            retainedBytes: 1, recordCount: 0)
    }
}

import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

private func encodedFixture(_ type: UTType, orientation: Int = 1, frames: Int = 1) throws -> Data {
    let pixels = Data([255, 0, 0, 255, 0, 0, 255, 255])
    let image = CGImage(width: 2, height: 1, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: 8,
        space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.last.rawValue),
        provider: CGDataProvider(data: pixels as CFData)!, decode: nil, shouldInterpolate: false, intent: .defaultIntent)!
    let bytes = NSMutableData()
    let destination = CGImageDestinationCreateWithData(bytes, type.identifier as CFString, frames, nil)!
    for _ in 0..<frames { CGImageDestinationAddImage(destination, image, [kCGImagePropertyOrientation: orientation] as CFDictionary) }
    guard CGImageDestinationFinalize(destination) else { throw BoundedImageImport.Failure.invalidImage }
    return bytes as Data
}
@Test func encodedPNGAndJPEGAreAcceptedAndEXIFOrientationIsNormalized() throws {
    let png = try BoundedImageImport.decode(encodedFixture(.png))
    #expect(png.width == 2 && png.height == 1)
    let jpeg = try BoundedImageImport.decode(encodedFixture(.jpeg, orientation: 6))
    #expect(jpeg.width == 1 && jpeg.height == 2)
}
@Test func actualUnsupportedTypeMultiFrameAndEncodedByteLimitReject() throws {
    let unsupported = try encodedFixture(.tiff)
    #expect(throws: BoundedImageImport.Failure.unsupportedFormat) { try BoundedImageImport.decode(unsupported) }
    let multiFrame = try encodedFixture(.tiff, frames: 2)
    #expect(throws: BoundedImageImport.Failure.invalidImage) { try BoundedImageImport.decode(multiFrame) }
    #expect(throws: BoundedImageImport.Failure.tooLarge) {
        try BoundedImageImport.decode(Data(repeating: 0, count: BoundedImageImport.maximumFileBytes + 1))
    }
}

@Test func cancelledSelectedReadStopsBeforeFileAccess() async throws {
    let absent = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent()
        .deletingLastPathComponent().appendingPathComponent(".verification/cancelled-" + UUID().uuidString + ".png")
    let worker = Task {
        withUnsafeCurrentTask { $0?.cancel() }
        return try BoundedImageImport.readSelectedFile(absent)
    }
    await #expect(throws: CancellationError.self) { try await worker.value }
}
