// 
//  RegisterCreatePasswordPresenter.swift
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

final public class RegisterCreatePasswordPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterCreatePasswordInteractor!
    public var navigationState: StateObject<RegisterCreatePasswordNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func validatePassword(password: String) {
        if !self.interactor.entity.validate {
            self.navigationState.wrappedValue.createPasswordEntity = RegisterCreatePasswordEntity(
                email: self.interactor.entity.email,
                password: password,
                userName: self.interactor.entity.userName,
                validate: true
            )
            
            self.navigationState.wrappedValue.navigateToCreatePassword = true
            return
        }
        
        if self.interactor.entity.password != password {
            self.showAlert {
                IOAlertData(
                    title: nil,
                    message: .registerInputErrorPasswordMatch,
                    buttons: [.commonOk],
                    handler: nil
                )
            }
            
            return
        }
        
        self.interactor.hashPassword(password: password)
    }
    
    func navigateToProfile(hashedPassword: String) {
        self.navigationState.wrappedValue.profileEntity = RegisterProfileEntity(
            email: self.interactor.entity.email,
            password: hashedPassword,
            userName: self.interactor.entity.userName
        )
        self.navigationState.wrappedValue.navigateToProfile = true
    }
}
