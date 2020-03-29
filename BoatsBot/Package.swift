// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "BoatsBot",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "BoatsBot", targets: [
            "BoatsBot"
        ])
    ],
    dependencies: [
        .package(path: "../BoatsKit")
    ],
    targets: [
        .target(name: "BoatsBot", dependencies: [
            "BoatsKit"
        ]),
        .testTarget(name: "BoatsBotTests", dependencies: [
            "BoatsKit",
            "BoatsBot"
        ])
    ]
)
