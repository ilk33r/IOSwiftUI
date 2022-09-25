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
        self.localization.changeLocalizationBundle(bundleName: "SwiftUISampleApp_SwiftUISampleAppResources")
        self.localization.changeLanguage(type: self.configuration.defaultLocale)
        AppTheme.applyTheme()
    }
}
