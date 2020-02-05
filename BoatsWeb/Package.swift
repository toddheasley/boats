// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "BoatsWeb",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(name: "BoatsWeb", targets: [
            "BoatsWeb"
        ])
    ],
    dependencies: [
        .package(path: "../BoatsKit")
    ],
    targets: [
        .target(name: "BoatsWeb", dependencies: [
            "BoatsKit"
        ]),
        .testTarget(name: "BoatsWebTests", dependencies: [
            "BoatsKit",
            "BoatsWeb"
        ])
    ]
)
