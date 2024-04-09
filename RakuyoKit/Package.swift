// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RakuyoKit",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v5),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "RakuyoKit", targets: ["RakuyoKit"]),
        .library(name: "RAKCore", targets: ["RAKCore"]),
        .library(name: "RAKConfig", targets: ["RAKConfig"]),
        .library(name: "RAKBase", targets: ["RAKBase"]),
        .library(name: "RAKNotification", targets: ["RAKNotification"]),
        .library(name: "RAKEpoxy", targets: ["RAKEpoxy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0"),
        .package(url: "https://github.com/RakuyoKit/RaLog.git", from: "1.7.1"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
        .package(url: "https://github.com/airbnb/epoxy-ios.git", from: "0.10.0"),
    ],
    targets: [
        .target(
            name: "RakuyoKit",
            dependencies: [
                "RAKConfig",
                "RAKBase",
                "RAKNotification",
                "RAKEpoxy",
            ]),
        .target(
            name: "RAKCore",
            dependencies: ["RaLog", "Then"],
            path: "Sources/Core",
            resources: [
                .copy("../PrivacyInfo.xcprivacy"),
            ]),
        .target(
            name: "RAKConfig",
            dependencies: ["RAKCore"],
            path: "Sources/Config"),
        .target(
            name: "RAKBase",
            dependencies: ["RAKConfig"],
            path: "Sources/Base"),
        .target(
            name: "RAKNotification",
            dependencies: ["RAKCore"],
            path: "Sources/Notification"),
        .target(
            name: "RAKEpoxy",
            dependencies: [
                "RAKConfig",
                .product(name: "EpoxyCollectionView", package: "epoxy-ios"),
            ],
            path: "Sources/Epoxy"),
        .testTarget(
            name: "RakuyoKitTests",
            dependencies: ["RakuyoKit"]),
    ]
)

let swiftlintPlugin = Target.PluginUsage.plugin(name: "SwiftLintPlugin", package: "SwiftLint")

for i in package.targets.indices {
    if package.targets[i].plugins == nil {
        package.targets[i].plugins = [swiftlintPlugin]
    } else {
        package.targets[i].plugins?.append(swiftlintPlugin)
    }
}
