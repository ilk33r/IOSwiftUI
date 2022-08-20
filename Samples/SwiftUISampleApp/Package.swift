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
            type: .static,
            targets: ["SwiftUISampleApp"]),
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .target(
            name: "SwiftUISampleApp",
            dependencies: ["IOSwiftUI"])
    ]
)
