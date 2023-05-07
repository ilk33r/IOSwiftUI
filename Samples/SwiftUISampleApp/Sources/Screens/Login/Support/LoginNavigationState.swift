// 
//  LoginNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class LoginNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToPassword = false
    
    var loginPasswordEntity: LoginPasswordEntity?
    
    // MARK: - Navigations
    
    func navigateToPassword(email: String) {
        self.loginPasswordEntity = LoginPasswordEntity(email: email)
        self.navigateToPassword = true
    }
}
