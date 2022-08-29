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
    
    var entity: PhotoGalleryEntity!
    @Published public var navigateToGallery: Bool = false
}
