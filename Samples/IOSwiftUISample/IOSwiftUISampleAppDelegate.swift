//
//  IOSwiftUISampleAppDelegate.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation
import UIKit
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

#if DEBUG
import IOSwiftUIScreensHTTPDebugger
#endif

final class IOSwiftUISampleAppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSettingImpl
    
    // MARK: - Privates
    
    #if DEBUG
    @IOInject private var simulationHTTPClient: IOHTTPClientSimulationImpl
    
    private var alertPresenter: IOAlertPresenterImpl?
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
        self.alertPresenter = IOAlertPresenterImpl()
        
        self.appleSettings.addListener { [weak self] in
            self?.settingValueChanged()
        }
        
        if self.appleSettings.bool(for: .debugSimulateHTTPClient) {
            do {
                try self.simulationHTTPClient.loadArchive()
            } catch let error {
                self.alertPresenter?.show {
                    IOAlertData(title: nil, message: error.localizedDescription, buttons: ["Ok"], handler: nil)
                }
            }
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
        
        if self.appleSettings.bool(for: .debugRecordHTTPCalls) {
            self.recordHTTPCalls()
        }
    }
    
    private func recordHTTPCalls() {
        let networkSerializer = IONetworkHistorySerializer()
        let archiveData = networkSerializer.archive()
        
        do {
            try self.simulationHTTPClient.saveArchive(archiveData)
            
            self.alertPresenter?.show {
                IOAlertData(title: nil, message: "HTTP history has been recorded successfully.", buttons: ["Ok"], handler: nil)
            }
        } catch let error {
            self.alertPresenter?.show {
                IOAlertData(title: nil, message: error.localizedDescription, buttons: ["Ok"], handler: nil)
            }
        }
        
        self.appleSettings.set(false, for: .debugRecordHTTPCalls)
    }
    #endif
}
