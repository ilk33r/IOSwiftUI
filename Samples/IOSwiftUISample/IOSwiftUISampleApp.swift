//
//  IOSwiftUISampleApp.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import IOSwiftUIPresentation
import SwiftUISampleAppScreens
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppComponents
import SwiftUISampleAppPresentation

@main
struct IOSwiftUISampleApp: App {
    
    @ObservedObject private var appEnvironment = SampleAppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appEnvironment.isLoggedIn {
                    HomeView(entity: HomeEntity())
                        .environmentObject(appEnvironment)
                        .transition(.opacity)
                } else {
                    SplashView(entity: SplashEntity())
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
        let _ = IOAppConfiguration(environment: .debug, locale: .en)
        AppTheme.applyTheme()
    }
}
