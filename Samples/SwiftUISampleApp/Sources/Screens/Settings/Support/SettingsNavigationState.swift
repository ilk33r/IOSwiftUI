// 
//  SettingsNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

final public class SettingsNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToUpdateProfile = false
    
    var updateProfileEntity: UpdateProfileEntity!
}
