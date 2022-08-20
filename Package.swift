// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IOSwiftUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "IOSwiftUI",
            type: .static,
            targets: ["IOSwiftUI"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.47.1/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "82ef90b7d76b02e41edd73423687d9cedf0bb9849dcbedad8df3a461e5a7b555"
        ),
        .target(
            name: "IOSwiftUI",
            dependencies: []),
        .testTarget(
            name: "IOSwiftUITests",
            dependencies: ["IOSwiftUI"]),
    ]
)
