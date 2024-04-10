// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RakuyoKitDemoDependencies",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v5),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "RakuyoKitDemoDependencies", targets: ["RakuyoKitDemoDependencies"]),
    ],
    dependencies: [
        .package(name: "RakuyoKit", path: "../..")
    ],
    targets: [
        .target(name: "RakuyoKitDemoDependencies", dependencies: ["RakuyoKit"], path: "Sources")
    ]
)
