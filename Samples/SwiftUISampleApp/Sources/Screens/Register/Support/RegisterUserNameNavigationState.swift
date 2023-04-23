// 
//  RegisterUserNameNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class RegisterUserNameNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToCreatePassword = false
    
    var createPasswordEntity: RegisterCreatePasswordEntity?
}
