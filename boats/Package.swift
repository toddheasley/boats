// swift-tools-version: 5.8

import PackageDescription

let package = Package(name: "Boats", platforms: [
        .macOS(.v13),
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
        .target(name: "BoatsWeb", dependencies: [
            "Boats"
        ], resources: [
            .process("Resources")
        ]),
        .testTarget(name: "BoatsTests", dependencies: [
            "Boats"
        ]),
        .target(name: "Boats", dependencies: [])
    ])
