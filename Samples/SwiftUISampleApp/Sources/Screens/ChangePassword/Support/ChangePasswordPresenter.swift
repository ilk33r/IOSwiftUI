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
        self.interactor.eventProcess.set(bool: false, forType: .tabBarVisibility)
    }
    
    func showTabBar() {
        self.interactor.eventProcess.set(bool: true, forType: .tabBarVisibility)
    }
    
    @MainActor
    func changePassword(oldPassword: String, newPassword: String) async {
        do {
            try await self.interactor.changePassword(oldPassword: oldPassword, newPassword: newPassword)
            await self.showAlertAsync {
                IOAlertData(title: nil, message: .successMessage, buttons: [.commonOk])
            }
            
            self.navigateToBack = true
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
