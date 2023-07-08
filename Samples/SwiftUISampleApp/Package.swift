// swift-tools-version: 5.9
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
            targets: ["SwiftUISampleApp"]
        ),
        .plugin(
            name: "RunAllTestCases",
            targets: ["RunAllTestCases"]
        )
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .plugin(
            name: "RunAllTestCases",
            capability: .command(
                intent: .custom(verb: "runalltests", description: "Run all test cases"),
                permissions: []
            ),
            dependencies: [
            ],
            path: "Plugins/RunAllTestCases"
        ),
        
        // This target auto generate IOBuildConfig.swift file from using Configuration.json
        .target(
            name: "SwiftUISampleAppConfigurations",
            dependencies: [],
            path: "Sources/Configuration",
            plugins: [
                .plugin(name: "IOBuildConfigGeneratorPlugin", package: "IOSwiftUI")
            ]
        ),
        .target(
            name: "SwiftUISampleAppResources",
            path: "Sources/Resources",
            resources: [.process("Files")]
        ),
        .target(
            name: "SwiftUISampleAppCommon",
            dependencies: [
                .product(name: "IOSwiftUI", package: "IOSwiftUI")
            ],
            path: "Sources/Common",
            swiftSettings: [.define("ENV_DEV", .when(configuration: .debug)),
                            .define("ENV_PROD", .when(configuration: .release))
            ]
        ),
        .target(name: "SwiftUISampleAppInfrastructure",
                dependencies: [
                    "SwiftUISampleAppCommon"
                ],
                path: "Sources/Infrastructure"),
        .target(name: "SwiftUISampleAppPresentation",
                dependencies: [
                    .product(name: "IOSwiftUI", package: "IOSwiftUI"),
                    "SwiftUISampleAppResources",
                    "SwiftUISampleAppCommon",
                    "SwiftUISampleAppInfrastructure"
                ],
                path: "Sources/Presentation"),
        .target(name: "SwiftUISampleAppScreensShared",
                dependencies: [
                    "SwiftUISampleAppResources",
                    "SwiftUISampleAppCommon",
                    "SwiftUISampleAppPresentation"
                ],
                path: "Sources/Screens/Shared"),
        
        // MARK: - Screens
        
            .target(name: "SwiftUISampleAppScreensSplash",
                    dependencies: ["SwiftUISampleAppScreensShared"],
                    path: "Sources/Screens/Splash"),
        .target(name: "SwiftUISampleAppScreensLogin",
                dependencies: [
                    .product(name: "IOSwiftUISupportBiometricAuthenticator", package: "IOSwiftUI"),
                    "SwiftUISampleAppScreensShared"
                ],
                path: "Sources/Screens/Login"),
        .target(name: "SwiftUISampleAppScreensHome",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Home"),
        .target(name: "SwiftUISampleAppScreensDiscover",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Discover"),
        .target(name: "SwiftUISampleAppScreensChatInbox",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/ChatInbox"),
        .target(name: "SwiftUISampleAppScreensProfile",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Profile"),
        .target(name: "SwiftUISampleAppScreensPhotoGallery",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/PhotoGallery"),
        .target(name: "SwiftUISampleAppScreensChat",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Chat"),
        .target(name: "SwiftUISampleAppScreensSettings",
                dependencies: [
                    .product(name: "IOSwiftUISupportBiometricAuthenticator", package: "IOSwiftUI"),
                    "SwiftUISampleAppScreensShared",
                ],
                path: "Sources/Screens/Settings"),
        .target(name: "SwiftUISampleAppScreensUpdateProfile",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/UpdateProfile"),
        .target(name: "SwiftUISampleAppScreensChangePassword",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/ChangePassword"),
        .target(name: "SwiftUISampleAppScreensSendOTP",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/SendOTP"),
        .target(name: "SwiftUISampleAppScreensWeb",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Web"),
        .target(name: "SwiftUISampleAppScreensFriends",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Friends"),
        .target(name: "SwiftUISampleAppScreensSearch",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Search"),
        .target(name: "SwiftUISampleAppScreensRegister",
                dependencies: [
                    .product(name: "IOSwiftUISupportNFC", package: "IOSwiftUI"),
                    .product(name: "IOSwiftUISupportVisionDetectText", package: "IOSwiftUI"),
                    "SwiftUISampleAppScreensShared"
                ],
                path: "Sources/Screens/Register"),
        .target(name: "SwiftUISampleAppScreensUserLocation",
                dependencies: [
                    .product(name: "IOSwiftUISupportLocation", package: "IOSwiftUI"),
                    "SwiftUISampleAppScreensShared"
                ],
                path: "Sources/Screens/UserLocation"),
        .target(name: "SwiftUISampleAppScreensStories",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Stories"),
        
        // MARK: - Application
        
        // This target auto generate AppRouter.swift file from Screens folder
            .target(name: "SwiftUISampleAppRouter",
                    dependencies: [
                        "SwiftUISampleAppScreensSplash",
                        "SwiftUISampleAppScreensLogin",
                        "SwiftUISampleAppScreensHome",
                        "SwiftUISampleAppScreensDiscover",
                        "SwiftUISampleAppScreensChatInbox",
                        "SwiftUISampleAppScreensProfile",
                        "SwiftUISampleAppScreensPhotoGallery",
                        "SwiftUISampleAppScreensChat",
                        "SwiftUISampleAppScreensSettings",
                        "SwiftUISampleAppScreensUpdateProfile",
                        "SwiftUISampleAppScreensChangePassword",
                        "SwiftUISampleAppScreensSendOTP",
                        "SwiftUISampleAppScreensWeb",
                        "SwiftUISampleAppScreensFriends",
                        "SwiftUISampleAppScreensSearch",
                        "SwiftUISampleAppScreensRegister",
                        "SwiftUISampleAppScreensUserLocation",
                        "SwiftUISampleAppScreensStories"
                    ],
                    path: "Sources/Router",
                    plugins: [ .plugin(name: "IORouterGeneratorPlugin", package: "IOSwiftUI") ]),
        
            .target(
                name: "SwiftUISampleApp",
                dependencies: [
                    .product(name: "IOSwiftUI", package: "IOSwiftUI"),
                    "SwiftUISampleAppConfigurations",
                    "SwiftUISampleAppResources",
                    "SwiftUISampleAppCommon",
                    "SwiftUISampleAppInfrastructure",
                    "SwiftUISampleAppPresentation",
                    "SwiftUISampleAppScreensShared",
                    "SwiftUISampleAppScreensSplash",
                    "SwiftUISampleAppScreensLogin",
                    "SwiftUISampleAppScreensHome",
                    "SwiftUISampleAppScreensDiscover",
                    "SwiftUISampleAppScreensChatInbox",
                    "SwiftUISampleAppScreensProfile",
                    "SwiftUISampleAppScreensPhotoGallery",
                    "SwiftUISampleAppScreensChat",
                    "SwiftUISampleAppScreensSettings",
                    "SwiftUISampleAppScreensUpdateProfile",
                    "SwiftUISampleAppScreensChangePassword",
                    "SwiftUISampleAppScreensSendOTP",
                    "SwiftUISampleAppScreensWeb",
                    "SwiftUISampleAppScreensFriends",
                    "SwiftUISampleAppScreensSearch",
                    "SwiftUISampleAppScreensRegister",
                    "SwiftUISampleAppScreensUserLocation",
                    "SwiftUISampleAppRouter",
                    "SwiftUISampleAppScreensStories"
                ]
            ),
        
        // MARK: - Tests
        
            .target(
                name: "SwiftUISampleAppCommonTests",
                dependencies: [
                    .product(name: "IOSwiftUITestInfrastructure", package: "IOSwiftUI"),
                    "SwiftUISampleApp"
                ],
                path: "Tests/CommonTests"
            ),
        .testTarget(
            name: "SplashTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/SplashTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/LoginTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "DiscoverTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/DiscoverTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/SearchTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/HomeTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "RegisterTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/RegisterTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "ChatInboxTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/ChatInboxTests",
            resources: [.process("Files")]
        ),
        .testTarget(
            name: "ChatTests",
            dependencies: [
                "SwiftUISampleAppCommonTests"
            ],
            path: "Tests/Screens/ChatTests",
            resources: [.process("Files")]
        ),
    ]
)
