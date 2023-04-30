// 
//  HomeNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class HomeNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToCamera = false
    @Published public var navigateToPhotoLibrary = false
    @Published public var navigateToProfile = false
    @Published var selectedImage: UIImage?
    
    var cameraView: IOImagePickerView?
    var photoLibraryView: IOImagePickerView?
    
    func navigateToCameraPage() {
        self.cameraView = IOImagePickerView(
            sourceType: .camera,
            allowEditing: false
        ) { [weak self] image in
            self?.selectedImage = image
        }
        
        self.navigateToCamera = true
    }
    
    func navigateToPhotoLibraryPage() {
        self.photoLibraryView = IOImagePickerView(
            sourceType: .photoLibrary,
            allowEditing: false
        ) { [weak self] image in
            self?.selectedImage = image
        }
        
        self.navigateToPhotoLibrary = true
    }
}
