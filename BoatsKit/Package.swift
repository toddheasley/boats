// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "BoatsKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "BoatsKit", targets: [
            "BoatsKit"
        ])
    ],
    targets: [
        .target(name: "BoatsKit", dependencies: []),
        .testTarget(name: "BoatsKitTests", dependencies: [
            "BoatsKit"
        ])
    ]
)
