// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISampleApp",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftUISampleApp",
            targets: ["SwiftUISampleApp"]),
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .target(name: "SwiftUISampleAppConfigurations",
                dependencies: [],
                path: "Sources/Configuration",
                plugins: [ .plugin(name: "IOBuildConfigGeneratorPlugin", package: "IOSwiftUI") ]),
        .target(name: "SwiftUISampleAppResources",
                path: "Sources/Resources",
                resources: [.process("Files")]),
        .target(name: "SwiftUISampleAppCommon",
                dependencies: [.product(name: "IOSwiftUI", package: "IOSwiftUI")],
                path: "Sources/Common",
                swiftSettings: [.define("ENV_DEV", .when(configuration: .debug)),
                                .define("ENV_PROD", .when(configuration: .release))
                ]),
        .target(name: "SwiftUISampleAppInfrastructure",
                dependencies: ["SwiftUISampleAppCommon"],
                path: "Sources/Infrastructure"),
        .target(name: "SwiftUISampleAppPresentation",
                dependencies: [.product(name: "IOSwiftUI", package: "IOSwiftUI"),
                               "SwiftUISampleAppResources",
                               "SwiftUISampleAppCommon",
                               "SwiftUISampleAppInfrastructure"],
                path: "Sources/Presentation"),
        .target(
            name: "SwiftUISampleAppScreens",
            dependencies: ["SwiftUISampleAppResources",
                           "SwiftUISampleAppCommon",
                           "SwiftUISampleAppPresentation"],
            path: "Sources/Screens"),
        .target(
            name: "SwiftUISampleApp",
            dependencies: ["SwiftUISampleAppConfigurations",
                           "SwiftUISampleAppResources",
                           "SwiftUISampleAppCommon",
                           "SwiftUISampleAppInfrastructure",
                           "SwiftUISampleAppPresentation",
                           "SwiftUISampleAppScreens"])
    ]
)
