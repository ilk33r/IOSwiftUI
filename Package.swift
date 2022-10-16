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
            targets: ["IOSwiftUI"]),
        .plugin(name: "IOBuildConfigGeneratorPlugin",
                targets: ["IOBuildConfigGeneratorPlugin"]),
        .plugin(name: "IORouterGeneratorPlugin",
                targets: ["IORouterGeneratorPlugin"])
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
        .plugin(name: "IORouterGeneratorPlugin",
                capability: .buildTool(),
                dependencies: []),
        /*
        // This target auto generate IOBuildConfig.swift file from using Configuration.json
        .target(name: "IOSwiftUIConfigurations",
                dependencies: [],
                path: "Sources/Configuration",
                plugins: [ //.plugin(name: "IOBuildConfigGeneratorPlugin", package: "IOSwiftUI")
                           "IOBuildConfigGeneratorPlugin"]),
         */
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
        .target(name: "IOSwiftUIScreensShared",
                dependencies: ["IOSwiftUIPresentation"],
                path: "Sources/Screens/Shared"),
        
        // MARK: - Screens
        
        // MARK: - Application
        
        // This target auto generate AppRouter.swift file from Screens folder
        .target(name: "IOSwiftUIRouter",
                dependencies: ["IOSwiftUIScreensShared"],
                path: "Sources/Router",
                plugins: [ //.plugin(name: "IORouterGeneratorPlugin", package: "IOSwiftUI")
                    ]),
        
        .target(
            name: "IOSwiftUI",
            dependencies: ["IOSwiftUICommon",
                           "IOSwiftUIInfrastructure",
                           "IOSwiftUIPresentation",
                           "IOSwiftUIRouter"]),
        .testTarget(
            name: "IOSwiftUITests",
            dependencies: ["IOSwiftUI"]),
    ]
)
