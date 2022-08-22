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

@main
struct IOSwiftUISampleApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(entity: SplashEntity())
        }
    }
    
    init() {
        IOFontType.registerFontsIfNecessary(Bundle.resources)
        let _ = IOAppConfiguration(environment: .debug, locale: .en)
    }
}
