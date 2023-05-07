// 
//  LoginPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class LoginPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: LoginInteractor!
    public var navigationState: StateObject<LoginNavigationState>!
    
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
            try await self.interactor.checkMemberEmail(email: email)
            self.navigationState.wrappedValue.navigateToPassword(email: email)
        } catch let err {
            IOLogger.error(err.localizedDescription)
            
            await showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .errorUserNotFound,
                    buttons: [
                        .commonOk
                    ]
                )
            }
        }
    }
}
