// swift-tools-version: 6.0

import PackageDescription

let package: Package = Package(name: "Boats", platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
        .tvOS(.v17)
    ], products: [
        .executable(name: "boats-cli", targets: [
            "BoatsCLI"
        ]),
        .library(name: "BoatsWeb", targets: [
            "BoatsWeb"
        ]),
        .library(name: "Boats", targets: [
            "Boats"
        ])
    ], dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", branch: "main")
    ], targets: [
        .executableTarget(name: "BoatsCLI", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "BoatsWeb",
            "Boats"
        ]),
        .testTarget(name: "BoatsWebTests", dependencies: [
            "BoatsWeb",
            "Boats"
        ]),
        .target(name: "BoatsWeb", dependencies: [
            "Boats"
        ]),
        .testTarget(name: "BoatsTests", dependencies: [
            "Boats"
        ]),
        .target(name: "Boats", dependencies: [])
    ])
