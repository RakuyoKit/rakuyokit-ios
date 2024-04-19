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
        .library(name: "RAKCore", targets: ["RAKCore", "RAKFixCrashOnInputKeyboard"]),
        .library(name: "RAKConfig", targets: ["RAKConfig"]),
        .library(name: "RAKBase", targets: ["RAKBase"]),
        .library(name: "RAKNotification", targets: ["RAKNotification"]),
        .library(name: "RAKEncrypte", targets: ["RAKEncrypte"]),
        .library(name: "RAKLocalCache", targets: ["RAKLocalCache"]),
        .library(name: "RAKGradient", targets: ["RAKGradient"]),
        .library(name: "RAKCombine", targets: ["RAKCombine"]),
        .library(name: "RAKEpoxy", targets: ["RAKEpoxy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0"),
        .package(url: "https://github.com/RakuyoKit/RaLog.git", from: "1.7.1"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
        .package(url: "https://github.com/airbnb/epoxy-ios.git", from: "0.10.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.8.1"),
    ],
    targets: [
        .target(
            name: "RakuyoKit",
            dependencies: [
                "RAKBase",
                "RAKCombine",
                "RAKConfig",
                "RAKCore",
                "RAKEncrypte",
                "RAKGradient",
                "RAKLocalCache",
                "RAKNotification",
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
            name: "RAKEncrypte",
            dependencies: ["RAKConfig", "CryptoSwift"],
            path: "Sources/Encrypte"),
        
        .target(
            name: "RAKLocalCache",
            dependencies: ["RAKEncrypte"],
            path: "Sources/LocalCache"),
        
        .target(
            name: "RAKGradient",
            dependencies: ["RAKCore"],
            path: "Sources/Gradient"),
        
        .target(
            name: "RAKFixCrashOnInputKeyboard",
            path: "Sources/FixCrashOnInputKeyboard"),
        
        .target(
            name: "RAKCombine",
            dependencies: ["RAKCore", "_RAKCombineRuntime"],
            path: "Sources/Combine/Core"),
        .target(
            name: "_RAKCombineRuntime",
            path: "Sources/Combine/Runtime"),
        
        .target(
            name: "RAKEpoxy",
            dependencies: [
                "RAKConfig",
                .product(name: "Epoxy", package: "epoxy-ios"),
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
