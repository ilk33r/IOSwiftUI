// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISampleApp",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
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
        .target(name: "SwiftUISampleAppResources",
                path: "Sources/Resources",
                resources: [.process("Files")]),
        .target(name: "SwiftUISampleAppCommon",
                dependencies: ["IOSwiftUI"],
                path: "Sources/Common",
                swiftSettings: [.define("ENV_DEV", .when(configuration: .debug)),
                                .define("ENV_PROD", .when(configuration: .release))
                ]),
        .target(name: "SwiftUISampleAppPresentation",
                dependencies: ["IOSwiftUI",
                               "SwiftUISampleAppResources",
                               "SwiftUISampleAppCommon"],
                path: "Sources/Presentation"),
        .target(name: "SwiftUISampleAppComponents",
                dependencies: ["IOSwiftUI",
                               "SwiftUISampleAppResources",
                               "SwiftUISampleAppCommon",
                               "SwiftUISampleAppPresentation"],
                path: "Sources/Components"),
        .target(
            name: "SwiftUISampleAppScreens",
            dependencies: ["SwiftUISampleAppResources",
                           "SwiftUISampleAppCommon",
                           "SwiftUISampleAppComponents",
                           "SwiftUISampleAppPresentation"],
            path: "Sources/Screens"),
        .target(
            name: "SwiftUISampleApp",
            dependencies: ["SwiftUISampleAppResources",
                           "SwiftUISampleAppCommon",
                           "SwiftUISampleAppComponents",
                           "SwiftUISampleAppPresentation",
                           "SwiftUISampleAppScreens"])
    ]
)
