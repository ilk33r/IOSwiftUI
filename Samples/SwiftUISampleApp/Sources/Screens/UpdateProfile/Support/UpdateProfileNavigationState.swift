// 
//  UpdateProfileNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class UpdateProfileNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    public var alertData: IOAlertData!
    public var showAlert = CurrentValueSubject<Bool, Never>(false)
    
//    @Published public var navigateToPage: Bool = false
}
