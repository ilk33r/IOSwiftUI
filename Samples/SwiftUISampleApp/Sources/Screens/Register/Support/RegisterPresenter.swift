// 
//  RegisterPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class RegisterPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterInteractor!
    public var navigationState: StateObject<RegisterNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    @MainActor
    func checkMember(email: String) async {
        do {
            try await self.interactor.checkMember(email: email)
            self.navigationState.wrappedValue.userNameEntity = RegisterUserNameEntity(email: email)
            self.navigationState.wrappedValue.navigateToUserName = true
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
