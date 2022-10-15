// 
//  ProfileNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final class ProfileNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToGallery = false
    @Published public var navigateToMessage = false
    
    var entity: PhotoGalleryEntity!
}
