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
    
    @MainActor
    func checkUserName(userName: String) async {
        do {
            try await self.interactor.checkUserName(userName: userName)
            self.navigationState.wrappedValue.navigateToCreatePassword(
                createPasswordEntity: RegisterCreatePasswordEntity(
                    email: self.interactor.entity.email,
                    password: "",
                    userName: userName,
                    validate: false
                )
            )
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
