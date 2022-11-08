// 
//  UserLocationNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class UserLocationNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    public var alertData: IOAlertData!
    public var showAlert = CurrentValueSubject<Bool, Never>(false)
    
//    @Published public var navigateToPage = false
}
