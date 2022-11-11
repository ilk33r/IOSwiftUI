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
    
    public var alertData: IOAlertData!
    public var showAlert = CurrentValueSubject<Bool, Never>(false)
    
    @Published public var navigateToCamera = false
    @Published public var navigateToPhotoLibrary = false
    @Published public var navigateToUpdateProfile = false
    
    var updateProfileEntity: UpdateProfileEntity!
}
