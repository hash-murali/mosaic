// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "Mosaic",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(name: "MosaicCore", targets: ["MosaicCore"]),
        .executable(name: "MosaicDemo", targets: ["MosaicDemo"])
    ],
    targets: [
        .target(name: "MosaicCore"),
        .executableTarget(name: "MosaicDemo", dependencies: ["MosaicCore"]),
        .testTarget(name: "MosaicCoreTests", dependencies: ["MosaicCore"])
    ]
)
