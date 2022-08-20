// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISampleApp",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
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
        .target(name: "SwiftUISampleAppComponents",
                dependencies: ["IOSwiftUI"],
                path: "Sources/Components"),
        .target(
            name: "SwiftUISampleAppScreens",
            dependencies: ["SwiftUISampleAppComponents"],
            path: "Sources/Screens"),
        .target(
            name: "SwiftUISampleApp",
            dependencies: ["SwiftUISampleAppComponents",
                           "SwiftUISampleAppScreens"])
    ]
)
