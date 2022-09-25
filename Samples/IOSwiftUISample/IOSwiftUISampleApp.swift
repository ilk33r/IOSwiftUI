//
//  IOSwiftUISampleApp.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreens
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppComponents
import SwiftUISampleAppPresentation

@main
struct IOSwiftUISampleApp: App {
    
    @IOInject private var configuration: IOConfigurationImpl
    @IOInject private var localization: IOLocalizationImpl
    
    @ObservedObject private var appEnvironment = SampleAppEnvironment()
    
    let splashView = SplashView(entity: SplashEntity())
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appEnvironment.isLoggedIn {
                    HomeView(entity: HomeEntity())
                        .environmentObject(appEnvironment)
                        .transition(.opacity)
                } else {
                    splashView
                        .environmentObject(appEnvironment)
                        .transition(.opacity)
                }
                
                if appEnvironment.showLoading {
                    IndicatorView()
                        .transition(.opacity)
                }
            }
        }
    }
    
    init() {
        IOFontType.registerFontsIfNecessary(Bundle.resources)
        self.localization.changeLocalizationBundle(bundleName: "SwiftUISampleApp_SwiftUISampleAppResources")
        self.localization.changeLanguage(type: self.configuration.defaultLocale)
        AppTheme.applyTheme()
    }
}
