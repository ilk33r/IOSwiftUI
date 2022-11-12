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
        // This target auto generate IOBuildConfig.swift file from using Configuration.json
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
        .target(name: "SwiftUISampleAppScreensShared",
                dependencies: ["SwiftUISampleAppResources",
                               "SwiftUISampleAppCommon",
                               "SwiftUISampleAppPresentation"],
                path: "Sources/Screens/Shared"),
        
        // MARK: - Screens
        
        .target(name: "SwiftUISampleAppScreensSplash",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Splash"),
        .target(name: "SwiftUISampleAppScreensLogin",
                dependencies: ["SwiftUISampleAppScreensShared"],
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
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/Settings"),
        .target(name: "SwiftUISampleAppScreensUpdateProfile",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/UpdateProfile"),
        .target(name: "SwiftUISampleAppScreensChangePassword",
                dependencies: ["SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/ChangePassword"),
        .target(name: "SwiftUISampleAppScreensUserLocation",
                dependencies: [.product(name: "IOSwiftUISupportLocation", package: "IOSwiftUI"),
                               "SwiftUISampleAppScreensShared"],
                path: "Sources/Screens/UserLocation"),
//        .target(name: "SwiftUISampleAppScreensRegister",
//                dependencies: ["SwiftUISampleAppScreensShared"],
//                path: "Sources/Screens/Register"),
        
        // MARK: - Application
        
        // This target auto generate AppRouter.swift file from Screens folder
        .target(name: "SwiftUISampleAppRouter",
                dependencies: ["SwiftUISampleAppScreensSplash",
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
                               "SwiftUISampleAppScreensUserLocation"],
                path: "Sources/Router",
                plugins: [ .plugin(name: "IORouterGeneratorPlugin", package: "IOSwiftUI") ]),
        
        .target(
            name: "SwiftUISampleApp",
            dependencies: ["SwiftUISampleAppConfigurations",
                           "SwiftUISampleAppResources",
                           "SwiftUISampleAppCommon",
                           "SwiftUISampleAppInfrastructure",
                           "SwiftUISampleAppPresentation",
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
                           "SwiftUISampleAppScreensUserLocation",
                           "SwiftUISampleAppRouter"])
    ]
)
