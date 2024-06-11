// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RakuyoKit",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "RakuyoKit", targets: ["RakuyoKit"]),
        .library(name: "RAKCore", targets: ["RAKCore", "RAKFixCrashOnInputKeyboard"]),
        .library(name: "RAKConfig", targets: ["RAKConfig"]),
        .library(name: "RAKBase", targets: ["RAKBase"]),
        .library(name: "RAKCodable", targets: ["RAKCodable"]),
        .library(name: "RAKNotification", targets: ["RAKNotification"]),
        .library(name: "RAKEncrypte", targets: ["RAKEncrypte"]),
        .library(name: "RAKLocalCache", targets: ["RAKLocalCache"]),
        .library(name: "RAKGradient", targets: ["RAKGradient"]),
        .library(name: "RAKCombine", targets: ["RAKCombine"]),
        .library(name: "RAKEpoxy", targets: ["RAKEpoxy"]),
        .library(name: "RAKGRDB", targets: ["RAKGRDB"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.8.2"),
        .package(url: "https://github.com/airbnb/epoxy-ios.git", from: "0.10.0"),
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "6.27.0"),
        .package(url: "https://github.com/RakuyoKit/RaLog.git", from: "1.7.3"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "RakuyoKit",
            dependencies: [
                "RAKBase",
                "RAKCodable",
                "RAKCombine",
                "RAKConfig",
                "RAKCore",
                "RAKEncrypte",
                "RAKGradient",
                "RAKLocalCache",
                "RAKNotification",
            ]
        ),
        
        .target(
            name: "RAKCore",
            dependencies: ["RaLog", "Then"],
            path: "Sources/Core",
            resources: [
                .process("../PrivacyInfo.xcprivacy"),
            ]
        ),
        
        .target(
            name: "RAKConfig",
            dependencies: ["RAKCore"],
            path: "Sources/Config"
        ),
        
        .target(
            name: "RAKBase",
            dependencies: ["RAKConfig"],
            path: "Sources/Base"
        ),
        
        .target(
            name: "RAKCodable",
            dependencies: ["RAKCore"],
            path: "Sources/Codable"
        ),

        .target(
            name: "RAKNotification",
            dependencies: ["RAKCore"],
            path: "Sources/Notification"
        ),
        
        .target(
            name: "RAKEncrypte",
            dependencies: ["RAKConfig", "RAKCodable", "CryptoSwift"],
            path: "Sources/Encrypte"
        ),
        
        .target(
            name: "RAKLocalCache",
            dependencies: ["RAKEncrypte"],
            path: "Sources/LocalCache"
        ),
        
        .target(
            name: "RAKGradient",
            dependencies: ["RAKCore"],
            path: "Sources/Gradient"
        ),
        
        .target(
            name: "RAKFixCrashOnInputKeyboard",
            path: "Sources/FixCrashOnInputKeyboard",
            cSettings: [
                .define("RAK_NOT_SUPPORT", .when(platforms: [.watchOS, .macOS])),
            ]
        ),
        
        .target(
            name: "RAKCombine",
            dependencies: ["RAKCore", "_RAKCombineRuntime"],
            path: "Sources/Combine/Core"
        ),
        .target(
            name: "_RAKCombineRuntime",
            path: "Sources/Combine/Runtime"
        ),
        
        .target(
            name: "RAKEpoxy",
            dependencies: [
                "RAKConfig",
                "RAKBase",
                .product(name: "Epoxy", package: "epoxy-ios", condition: .when(platforms: [.iOS])),
            ],
            path: "Sources/Epoxy"
        ),

        .target(
            name: "RAKGRDB",
            dependencies: [
                "RAKCore",
                .product(name: "GRDB", package: "GRDB.swift"),
            ],
            path: "Sources/GRDB"
        ),

        .testTarget(
            name: "RakuyoKitTests",
            dependencies: ["RakuyoKit"]
        ),
    ]
)

// Add the Rakuyo Swift formatting plugin if possible
package.dependencies.append(.package(url: "https://github.com/RakuyoKit/swift.git", from: "1.1.3"))
