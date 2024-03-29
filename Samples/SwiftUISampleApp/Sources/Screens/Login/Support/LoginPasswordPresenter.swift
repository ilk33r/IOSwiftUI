// 
//  LoginPasswordPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class LoginPasswordPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: LoginPasswordInteractor!
    public var navigationState: StateObject<LoginPasswordNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    @MainActor
    func login(password: String) async {
        do {
            try await self.interactor.login(password: password)
            self.environment.wrappedValue.appScreen = .loggedIn
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
