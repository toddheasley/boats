// swift-tools-version: 5.7

import PackageDescription

let package = Package(name: "boats", platforms: [
        .macOS(.v12),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16)
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
        .testTarget(name: "BoatsTests", dependencies: [
            "Boats"
        ]),
        .target(name: "BoatsWeb", dependencies: [
            "Boats"
        ]),
        .target(name: "Boats", dependencies: [])
    ])
