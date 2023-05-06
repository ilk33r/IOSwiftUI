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
            targets: ["IOSwiftUI"]
        ),
        .library(
            name: "IOSwiftUISupportBiometricAuthenticator",
            targets: ["IOSwiftUISupportBiometricAuthenticator"]
        ),
        .library(
            name: "IOSwiftUISupportCamera",
            targets: ["IOSwiftUISupportCamera"]
        ),
        .library(
            name: "IOSwiftUISupportLocation",
            targets: ["IOSwiftUISupportLocation"]
        ),
        .library(
            name: "IOSwiftUISupportNFC",
            targets: ["IOSwiftUISupportNFC"]
        ),
        .library(
            name: "IOSwiftUISupporPushNotification",
            targets: ["IOSwiftUISupporPushNotification"]
        ),
        .library(
            name: "IOSwiftUISupportVisionDetectText",
            targets: ["IOSwiftUISupportVisionDetectText"]
        ),
        .library(
            name: "IOSwiftUITestInfrastructure",
            targets: ["IOSwiftUITestInfrastructure"]
        ),
        .plugin(
            name: "IOBuildConfigGeneratorPlugin",
            targets: ["IOBuildConfigGeneratorPlugin"]
        ),
        .plugin(
            name: "IORouterGeneratorPlugin",
            targets: ["IORouterGeneratorPlugin"]
        ),
        .plugin(
            name: "IOSwiftLintPlugin",
            targets: ["IOSwiftLintPlugin"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.51.0/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "9fbfdf1c2a248469cfbe17a158c5fbf96ac1b606fbcfef4b800993e7accf43ae"
        ),
        .plugin(
            name: "IOBuildConfigGeneratorPlugin",
            capability: .buildTool(),
            dependencies: []
        ),
        .plugin(
            name: "IORouterGeneratorPlugin",
            capability: .buildTool(),
            dependencies: []
        ),
        .plugin(
            name: "IOSwiftLintPlugin",
            capability: .command(
                intent: .custom(verb: "ioswiftlint", description: "Lint source files"),
                permissions: []
            ),
            dependencies: [
                "SwiftLintBinary"
            ],
            path: "Plugins/IOSwiftLint"
        ),
        /*
         // This target auto generate IOBuildConfig.swift file from using Configuration.json
         .target(
         name: "IOSwiftUIConfigurations",
         dependencies: [],
         path: "Sources/Configuration",
         plugins: [
         //.plugin(name: "IOBuildConfigGeneratorPlugin", package: "IOSwiftUI")
         "IOBuildConfigGeneratorPlugin"
         ]
         ),
         */
        .target(
            name: "IOSwiftUIResources",
            path: "Sources/Resources",
            resources: [.process("Files")]
        ),
        .target(
            name: "IOSwiftUICommon",
            dependencies: [],
            path: "Sources/Common",
            swiftSettings: [
                .define("ENV_DEBUG", .when(configuration: .debug)),
                .define("ENV_RELEASE", .when(configuration: .release))
            ]
        ),
        .target(
            name: "IOSwiftUIInfrastructure",
            dependencies: ["IOSwiftUICommon"],
            path: "Sources/Infrastructure"
        ),
        .target(
            name: "IOSwiftUIPresentation",
            dependencies: [
                "IOSwiftUICommon",
                "IOSwiftUIInfrastructure"
            ],
            path: "Sources/Presentation"
        ),
        .target(
            name: "IOSwiftUIScreensShared",
            dependencies: ["IOSwiftUIPresentation"],
            path: "Sources/Screens/Shared"
        ),
        
        // MARK: - Support
        
            .target(
                name: "IOSwiftUISupportBiometricAuthenticator",
                dependencies: ["IOSwiftUIInfrastructure"],
                path: "Sources/Support/BiometricAuthenticator"
            ),
        .target(
            name: "IOSwiftUISupportCamera",
            dependencies: ["IOSwiftUIInfrastructure"],
            path: "Sources/Support/Camera"
        ),
        .target(name: "IOSwiftUISupportLocation",
                dependencies: [
                    "IOSwiftUIInfrastructure"
                ],
                path: "Sources/Support/Location"),
        .target(name: "IOSwiftUISupportNFC",
                dependencies: [
                    "IOSwiftUIInfrastructure"
                ],
                path: "Sources/Support/NFC"),
        .target(name: "IOSwiftUISupporPushNotification",
                dependencies: [
                    "IOSwiftUIInfrastructure"
                ],
                path: "Sources/Support/PushNotification"),
        .target(name: "IOSwiftUISupportVisionDetectText",
                dependencies: [
                    "IOSwiftUIInfrastructure",
                    "IOSwiftUISupportCamera"
                ],
                path: "Sources/Support/VisionDetectText"),
        
        // MARK: - Screens
        
            .target(name: "IOSwiftUIScreensHTTPDebugger",
                    dependencies: ["IOSwiftUIScreensShared"],
                    path: "Sources/Screens/HTTPDebugger"),
        
        // MARK: - Application
        
        // This target auto generate AppRouter.swift file from Screens folder
            .target(name: "IOSwiftUIRouter",
                    dependencies: [
                        "IOSwiftUIScreensShared"
                    ],
                    path: "Sources/Router",
                    plugins: [ //.plugin(name: "IORouterGeneratorPlugin", package: "IOSwiftUI")
                             ]
                   ),
        
        // MARK: - App Delegate
        
            .target(name: "IOSwiftUIApplication",
                    dependencies: [
                        "IOSwiftUICommon",
                        "IOSwiftUIInfrastructure",
                        "IOSwiftUIPresentation",
                        "IOSwiftUIScreensHTTPDebugger"
                    ],
                    path: "Sources/Application"),
        
        // MARK: - Library
        
            .target(
                name: "IOSwiftUI",
                dependencies: [
                    "IOSwiftUICommon",
                    "IOSwiftUIInfrastructure",
                    "IOSwiftUIPresentation",
                    "IOSwiftUIScreensHTTPDebugger",
                    "IOSwiftUIRouter",
                    "IOSwiftUIApplication"
                ]),
        
        // MARK: - Tests
        
            .target(
                name: "IOSwiftUITestInfrastructure",
                dependencies: [
                    "IOSwiftUICommon",
                    "IOSwiftUIInfrastructure",
                    "IOSwiftUIPresentation",
                ],
                path: "Tests/TestInfrastructure"
            ),
        .target(
            name: "IOSwiftUICommonTests",
            dependencies: [
                "IOSwiftUICommon",
                "IOSwiftUIInfrastructure",
                "IOSwiftUIPresentation",
                "IOSwiftUITestInfrastructure"
            ],
            path: "Tests/CommonTests"
        ),
        .testTarget(
            name: "IOSwiftUITestsSupportBiometricAuthenticatorTests",
            dependencies: [
                "IOSwiftUICommonTests",
                "IOSwiftUISupportBiometricAuthenticator"
            ],
            path: "Tests/Support/BiometricAuthenticatorTests"
        ),
        
            .testTarget(
                name: "IOSwiftUISupportNFCTests",
                dependencies: [
                    "IOSwiftUICommonTests",
                    "IOSwiftUISupportNFC"
                ],
                path: "Tests/Support/NFCTests"
            ),
        
            .testTarget(
                name: "IOSwiftUITests",
                dependencies: [
                    "IOSwiftUI",
                    "IOSwiftUICommonTests"
                ]
            ),
    ]
)
