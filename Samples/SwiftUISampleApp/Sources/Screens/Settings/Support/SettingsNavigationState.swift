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
    
    private(set) var cameraView: IOImagePickerView?
    private(set) var photoLibraryView: IOImagePickerView?
    private(set) var changePasswordEntity: ChangePasswordEntity?
    private(set) var updateProfileEntity: UpdateProfileEntity?
    private(set) var webEntity: WebEntity?
    
    // MARK: - Helper Methods
    
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
    
    func navigateToChangePassword(changePasswordEntity: ChangePasswordEntity?) {
        self.changePasswordEntity = changePasswordEntity
        self.navigateToChangePassword = true
    }
    
    func navigateToUpdateProfile(updateProfileEntity: UpdateProfileEntity?) {
        self.updateProfileEntity = updateProfileEntity
        self.navigateToUpdateProfile = true
    }
    
    func navigateToWeb(webEntity: WebEntity?) {
        self.webEntity = webEntity
        self.navigateToWeb = true
    }
}
