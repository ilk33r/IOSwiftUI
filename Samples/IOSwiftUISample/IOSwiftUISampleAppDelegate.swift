//
//  IOSwiftUISampleAppDelegate.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation
import UIKit
import IOSwiftUIInfrastructure

#if DEBUG
import IOSwiftUIScreensHTTPDebugger
#endif

final class IOSwiftUISampleAppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSettingImpl
    
    // MARK: - Privates
    
    #if DEBUG
    private var debuggerPresenter: HTTPDebuggerPresenter?
    #endif
    
    // MARK: - Delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.configureApplication()
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Helper Method
    
    private func configureApplication() {
        #if DEBUG
        self.appleSettings.addListener { [weak self] in
            self?.settingValueChanged()
        }
        #endif
    }
    
    #if DEBUG
    private func settingValueChanged() {
        if self.appleSettings.bool(for: .debugHTTPMenuToggle) && self.debuggerPresenter == nil {
            self.debuggerPresenter = HTTPDebuggerPresenter()
            self.debuggerPresenter?.show()
        }
        
        if !self.appleSettings.bool(for: .debugHTTPMenuToggle) {
            self.debuggerPresenter?.dismiss()
            self.debuggerPresenter = nil
        }
    }
    #endif
}
