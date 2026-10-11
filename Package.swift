// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "Mosaic",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(name: "MosaicDomain", targets: ["MosaicDomain"]),
        .library(name: "MosaicPolicy", targets: ["MosaicPolicy"]),
        .library(name: "MosaicStorage", targets: ["MosaicStorage"]),
        .library(name: "MosaicCore", targets: ["MosaicCore"]),
        .library(name: "MosaicApplication", targets: ["MosaicApplication"]),
        .executable(name: "MosaicDemo", targets: ["MosaicDemo"]),
        .executable(name: "MosaicRecoveryCheck", targets: ["MosaicRecoveryCheck"])
    ],
    dependencies: [
        .package(url: "https://github.com/sqlcipher/SQLCipher.swift.git", exact: "4.19.0")
    ],
    targets: [
        .target(name: "MosaicStorage", dependencies: ["MosaicDomain", "MosaicPolicy",
            .product(name: "SQLCipher", package: "SQLCipher.swift")
        ], cSettings: [.define("SQLITE_HAS_CODEC")]),
        .testTarget(name: "MosaicStorageTests", dependencies: ["MosaicStorage"], cSettings: [.define("SQLITE_HAS_CODEC")]),
        .executableTarget(name: "MosaicRecoveryCheck", dependencies: ["MosaicStorage"]),
        .target(name: "MosaicDomain"),
        .target(name: "MosaicPolicy", dependencies: ["MosaicDomain"]),
        .testTarget(name: "MosaicPolicyTests", dependencies: ["MosaicDomain", "MosaicPolicy"]),
        .target(name: "MosaicApplication", dependencies: ["MosaicCore", "MosaicDomain", "MosaicPolicy", "MosaicStorage"]),
        .testTarget(name: "MosaicApplicationTests", dependencies: ["MosaicApplication"]),
        .target(name: "MosaicCore"),
        .executableTarget(name: "MosaicDemo", dependencies: ["MosaicCore", "MosaicApplication"]),
        .testTarget(name: "MosaicDemoTests", dependencies: ["MosaicDemo"]),
        .testTarget(name: "MosaicCoreTests", dependencies: ["MosaicCore"])
    ]
)
