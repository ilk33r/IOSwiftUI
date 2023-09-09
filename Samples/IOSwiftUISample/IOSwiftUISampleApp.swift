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
import SwiftUISampleAppRouter
import SwiftUISampleAppScreensShared

@main
struct IOSwiftUISampleApp: App {
    
    // MARK: - DI
    
    @IOInject private var alertPresenter: IOAlertPresenter
    @IOInject private var eventProcess: IOEventProcess
    @IOInject private var indicatorPresenter: IOIndicatorPresenter
    @IOInject private var pickerPresenter: IOPickerPresenter
    @IOInject private var toastPresenter: IOToastPresenter
    
    // MARK: - Privates
    
    private let splashView = IORouterUtilities.route(PreLoginRouters.self, .splash(entity: nil))
    private let homeView = IORouterUtilities.route(HomeRouters.self, .home(entity: nil))
    
    @UIApplicationDelegateAdaptor private var appDelegate: IOSwiftUISampleAppDelegate
    @ObservedObject private var appEnvironment = SampleAppEnvironment()
    
    @State private var deepLinkPresented = false
    @State private var deepLinkView: IORouterView?
    
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
            .onOpenURL { deepLinkUrl in
                guard let components = URLComponents(string: deepLinkUrl.absoluteString) else { return }
                guard let deepLink = DeepLinks.from(components: components) else { return }
                
                appEnvironment.showLoading = true
                Task {
                    do {
                        deepLinkView = try await deepLink.route(deepLinkUrlComponents: components)
                        appEnvironment.showLoading = false
                        deepLinkPresented = true
                    } catch let IOPresenterError.prefetch(title, message, buttonTitle) {
                        appEnvironment.showLoading = false
                        appEnvironment.alertData = IOAlertData(title: title, message: message, buttons: [buttonTitle])
                    } catch let err {
                        appEnvironment.showLoading = false
                        IOLogger.error(err.localizedDescription)
                    }
                }
            }
            .fullScreenCover(isPresented: $deepLinkPresented) {
                if let view = deepLinkView {
                    view
                        .setEnvironment(appEnvironment)
                } else {
                    EmptyView()
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
