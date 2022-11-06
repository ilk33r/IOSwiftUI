//
//  IOSwiftUISampleApp.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensSplash
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared
import IOSwiftUIRouter

@main
struct IOSwiftUISampleApp: App {
    
    @IOInject private var configuration: IOConfigurationImpl
    @IOInject private var fileCache: IOFileCacheImpl
    @IOInject private var httpClient: IOHTTPClientImpl
    @IOInject private var localization: IOLocalizationImpl
    
    @ObservedObject private var appEnvironment = SampleAppEnvironment()
    
    let splashView = IORouterUtilities.route(PreLoginRouters.self, .splash(entity: nil))
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appEnvironment.isLoggedIn {
                    IORouterUtilities.route(HomeRouters.self, .home(entity: nil))
                        .setEnvironment(appEnvironment)
                        .transition(.opacity)
                } else {
                    splashView
                        .setEnvironment(appEnvironment)
                        .transition(.opacity)
                }
                
                if appEnvironment.showLoading {
                    IndicatorView()
                        .transition(.opacity)
                }
            }
            .alert(isPresented: $appEnvironment.showAlert) {
                if appEnvironment.alertButtons.count > 1 {
                    return Alert(
                        title: Text(appEnvironment.alertTitle),
                        message: Text(appEnvironment.alertMessage),
                        primaryButton: .default(
                            Text(appEnvironment.alertButtons[0].localized),
                            action: {
                                appEnvironment.alertHandler?(0)
                            }
                        ),
                        secondaryButton: .destructive(
                            Text(appEnvironment.alertButtons[1].localized),
                            action: {
                                appEnvironment.alertHandler?(1)
                            }
                        )
                    )
                } else {
                    return Alert(
                        title: Text(appEnvironment.alertTitle),
                        message: Text(appEnvironment.alertMessage),
                        dismissButton: .default(
                            Text(appEnvironment.alertButtons[0].localized),
                            action: {
                                appEnvironment.alertHandler?(0)
                            }
                        )
                    )
                }
            }
        }
    }
    
    init() {
        IOFontType.registerFontsIfNecessary(Bundle.resources)
        IOLocalizationImpl.shared.setLocalizationBundle(bundleName: "SwiftUISampleApp_SwiftUISampleAppResources")
        IOLocalizationImpl.shared.changeLanguage(type: configuration.defaultLocale)
        AppTheme.applyTheme()
        
        httpClient.setDefaultHTTPHeaders(headers: [
            "Content-Type": "application/json",
            "X-IO-AUTHORIZATION": configuration.configForType(type: .networkingAuthorizationHeader)
        ])
        
        let cacheFileBeforeDate = Date()
        fileCache.removeFiles(beforeDate: cacheFileBeforeDate.date(bySubtractingDays: 3)!)
    }
}
