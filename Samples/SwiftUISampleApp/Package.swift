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
        .target(name: "SwiftUISampleAppPresentation",
                dependencies: ["IOSwiftUI",
                               "SwiftUISampleAppResources"],
                path: "Sources/Presentation"),
        .target(name: "SwiftUISampleAppComponents",
                dependencies: ["IOSwiftUI",
                               "SwiftUISampleAppResources",
                               "SwiftUISampleAppPresentation"],
                path: "Sources/Components"),
        .target(
            name: "SwiftUISampleAppScreens",
            dependencies: ["SwiftUISampleAppResources",
                           "SwiftUISampleAppComponents",
                           "SwiftUISampleAppPresentation"],
            path: "Sources/Screens"),
        .target(
            name: "SwiftUISampleApp",
            dependencies: ["SwiftUISampleAppResources",
                           "SwiftUISampleAppComponents",
                           "SwiftUISampleAppPresentation",
                           "SwiftUISampleAppScreens"])
    ]
)
