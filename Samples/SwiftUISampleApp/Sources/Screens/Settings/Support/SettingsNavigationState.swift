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
import UIKit

final public class SettingsNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToCamera = false
    @Published var navigateToChangePassword = false
    @Published var navigateToPhotoLibrary = false
    @Published var navigateToUpdateProfile = false
    @Published var navigateToWeb = false
    @Published var selectedImage: UIImage?
    
    var cameraView: IOImagePickerView?
    var photoLibraryView: IOImagePickerView?
    var changePasswordEntity: ChangePasswordEntity!
    var updateProfileEntity: UpdateProfileEntity!
    var webEntity: WebEntity!
    
    func navigateToCameraPage() {
        self.cameraView = IOImagePickerView(
            sourceType: .camera,
            allowEditing: true
        ) { [weak self] image in
            self?.selectedImage = image
        }
        
        self.navigateToCamera = true
    }
    
    func navigateToPhotoLibraryPage() {
        self.photoLibraryView = IOImagePickerView(
            sourceType: .photoLibrary,
            allowEditing: true
        ) { [weak self] image in
            self?.selectedImage = image
        }
        
        self.navigateToPhotoLibrary = true
    }
}
