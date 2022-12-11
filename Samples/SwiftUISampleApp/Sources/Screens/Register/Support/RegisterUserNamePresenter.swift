// 
//  RegisterUserNamePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class RegisterUserNamePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterUserNameInteractor!
    public var navigationState: StateObject<RegisterUserNameNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func navigateToCreatePassword(
        email: String,
        userName: String
    ) {
        self.navigationState.wrappedValue.createPasswordEntity = RegisterCreatePasswordEntity(
            email: email,
            password: "",
            userName: userName,
            validate: false
        )
        self.navigationState.wrappedValue.navigateToCreatePassword = true
    }
}
