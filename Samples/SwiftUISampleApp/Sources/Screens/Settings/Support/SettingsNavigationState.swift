// 
//  SettingsNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class SettingsNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToCamera = false
    @Published var navigateToChangePassword = false
    @Published var navigateToPhotoLibrary = false
    @Published var navigateToUpdateProfile = false
    @Published var navigateToWeb = false
    
    var changePasswordEntity: ChangePasswordEntity!
    var updateProfileEntity: UpdateProfileEntity!
    var webEntity: WebEntity!
}
