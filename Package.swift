// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IOSwiftUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "IOSwiftUI",
            type: .static,
            targets: ["IOSwiftUI"]),
        .plugin(name: "IOBuildConfigGeneratorPlugin",
                targets: ["IOBuildConfigGeneratorPlugin"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.47.1/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "82ef90b7d76b02e41edd73423687d9cedf0bb9849dcbedad8df3a461e5a7b555"
        ),
        .plugin(name: "IOBuildConfigGeneratorPlugin",
                capability: .buildTool(),
                dependencies: []),
        .target(name: "IOSwiftUIConfigurations",
                dependencies: [],
                path: "Sources/Configuration",
                plugins: [ //.plugin(name: "IOBuildConfigGeneratorPlugin", package: "IOSwiftUI")
                           "IOBuildConfigGeneratorPlugin"]),
        .target(name: "IOSwiftUIResources",
                path: "Sources/Resources",
                resources: [.process("Files")]),
        .target(name: "IOSwiftUICommon",
                dependencies: [],
                path: "Sources/Common",
                swiftSettings: [.define("ENV_DEBUG", .when(configuration: .debug)),
                                .define("ENV_RELEASE", .when(configuration: .release))
                ]),
        .target(name: "IOSwiftUIInfrastructure",
                dependencies: ["IOSwiftUICommon"],
                path: "Sources/Infrastructure"),
        .target(name: "IOSwiftUIPresentation",
                dependencies: ["IOSwiftUICommon",
                               "IOSwiftUIInfrastructure"],
                path: "Sources/Presentation"),
        .target(name: "IOSwiftUIComponents",
                dependencies: ["IOSwiftUICommon",
                               "IOSwiftUIInfrastructure",
                               "IOSwiftUIPresentation"],
                path: "Sources/Components"),
        .target(
            name: "IOSwiftUI",
            dependencies: ["IOSwiftUICommon",
                           "IOSwiftUIInfrastructure",
                           "IOSwiftUIPresentation",
                           "IOSwiftUIComponents"]),
        .testTarget(
            name: "IOSwiftUITests",
            dependencies: ["IOSwiftUI"]),
    ]
)
