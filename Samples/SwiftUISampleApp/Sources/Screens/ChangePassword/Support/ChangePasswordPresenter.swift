// 
//  ChangePasswordPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class ChangePasswordPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ChangePasswordInteractor!
    public var navigationState: StateObject<ChangePasswordNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var navigateToBack: Bool!
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func hideTabBar() {
//        self.interactor.appState.set(bool: true, forType: .tabBarIsHidden)
//        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    func showTabBar() {
//        self.interactor.appState.set(bool: false, forType: .tabBarIsHidden)
//        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    func updateSuccess() {
        self.showAlert { [weak self] in
            IOAlertData(title: nil, message: .changePasswordSuccessMessage, buttons: [.commonOk]) { [weak self] _ in
                self?.navigateToBack = true
            }
        }
    }
}
