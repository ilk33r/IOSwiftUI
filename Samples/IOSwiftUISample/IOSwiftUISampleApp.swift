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
    
    // MARK: - Privates
    
    @IOInject private var alertPresenter: IOAlertPresenter
    @IOInject private var indicatorPresenter: IOIndicatorPresenter
    @IOInject private var pickerPresenter: IOPickerPresenter
    @IOInject private var toastPresenter: IOToastPresenter
    
    @UIApplicationDelegateAdaptor private var appDelegate: IOSwiftUISampleAppDelegate
    @ObservedObject private var appEnvironment = SampleAppEnvironment()
    
    private let splashView = IORouterUtilities.route(PreLoginRouters.self, .splash(entity: nil))
    private let homeView = IORouterUtilities.route(HomeRouters.self, .home(entity: nil))
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if appEnvironment.appScreen == .loggedIn {
                    homeView
                        .setEnvironment(appEnvironment)
                        .transition(.opacity)
                } else {
                    splashView
                        .setEnvironment(appEnvironment)
                        .transition(.opacity)
                }
            }
        }
        .onChange(of: appEnvironment.showLoading) { newValue in
            if newValue {
                indicatorPresenter.show()
            } else {
                indicatorPresenter.dismiss()
            }
        }
        .onChange(of: appEnvironment.alertData) { newValue in
            if let newValue {
                alertPresenter.show {
                    newValue
                }
            }
        }
        .onChange(of: appEnvironment.datePickerData) { newValue in
            if let newValue {
                pickerPresenter.show {
                    newValue
                }
            } else {
                pickerPresenter.dismiss()
            }
        }
        .onChange(of: appEnvironment.pickerData) { newValue in
            if let newValue {
                pickerPresenter.show {
                    newValue
                }
            } else {
                pickerPresenter.dismiss()
            }
        }
        .onChange(of: appEnvironment.toastData) { newValue in
            if let newValue {
                toastPresenter.show {
                    newValue
                }
            } else {
                toastPresenter.dismiss()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
