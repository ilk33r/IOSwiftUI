//
//  SplashNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class SplashNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    public var alertData: IOAlertData!
    public var showAlert = CurrentValueSubject<Bool, Never>(false)
    
    @Published public var navigateToLogin = false
    @Published public var navigateToRegister = false
}
