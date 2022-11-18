//
//  IOAppDelegate.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation
import UIKit
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUIScreensHTTPDebugger

open class IOAppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - DI
    
    @IOInject public var appleSettings: IOAppleSetting
    @IOInject public var alertPresenter: IOAlertPresenter
    @IOInject public var httpClient: IOHTTPClient
    
    // MARK: - Privates
    
    private var debuggerPresenter: HTTPDebuggerPresenter?
    
    // MARK: - Delegate
    
    public func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        self.configureDI(container: IODIContainerImpl.shared)
        return true
    }
    
    open func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        self.configureApplication()
        return true
    }
    
    open func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Configuration
    
    open func configureApplication() {
        self.configureDebugger()
    }
    
    open func configureDI(container: IODIContainer) {
        IOAppAssembly.configureDI(container: container)
    }
    
    // MARK: - Debuggers
    
    open func configureDebugger() {
        self.appleSettings.addListener { [weak self] in
            self?.settingValueChanged()
        }
        
        if
            self.appleSettings.bool(for: .debugSimulateHTTPClient),
            let simulationHTTPClient = self.httpClient as? IOHTTPClientSimulationImpl
        {
            do {
                let networkSerializer = IONetworkHistorySerializer()
                let archiveData = try networkSerializer.loadArchive()
                simulationHTTPClient.loadArchive(networkHistory: archiveData)
            } catch let error {
                self.alertPresenter.show {
                    IOAlertData(title: nil, message: error.localizedDescription, buttons: ["Ok"], handler: nil)
                }
            }
        }
    }
    
    open func settingValueChanged() {
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
    
    open func recordHTTPCalls() {
        let networkSerializer = IONetworkHistorySerializer()
        let archiveData = networkSerializer.archive()
        
        do {
            try networkSerializer.saveArchive(archiveData)
            
            self.alertPresenter.show {
                IOAlertData(title: nil, message: "HTTP history has been recorded successfully.", buttons: ["Ok"], handler: nil)
            }
        } catch let error {
            self.alertPresenter.show {
                IOAlertData(title: nil, message: error.localizedDescription, buttons: ["Ok"], handler: nil)
            }
        }
        
        self.appleSettings.set(false, for: .debugRecordHTTPCalls)
    }
}
