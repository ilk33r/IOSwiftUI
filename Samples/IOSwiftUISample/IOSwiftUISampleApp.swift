//
//  IOSwiftUISampleApp.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUISampleAppScreens
import SwiftUI

@main
struct IOSwiftUISampleApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(presenter: SplashPresenter())
        }
    }
}
