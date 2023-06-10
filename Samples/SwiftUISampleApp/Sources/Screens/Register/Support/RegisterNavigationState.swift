// 
//  RegisterNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class RegisterNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToUserName = false
    
    private(set) var userNameEntity: RegisterUserNameEntity?
    
    // MARK: - Helper Methods
    
    func navigateToUserName(userNameEntity: RegisterUserNameEntity?) {
        self.userNameEntity = userNameEntity
        self.navigateToUserName = true
    }
}
