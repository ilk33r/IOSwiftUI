//
//  SplashNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final public class SplashNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToLogin = false
    @Published public var navigateToRegister = false
}
