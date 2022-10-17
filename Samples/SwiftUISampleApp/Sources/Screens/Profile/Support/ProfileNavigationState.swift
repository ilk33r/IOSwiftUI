// 
//  ProfileNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

final public class ProfileNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published public var navigateToChat = false
    @Published public var navigateToGallery = false
    @Published public var navigateToMessage = false
    
    var chatEntity: ChatEntity!
    var galleryEntity: PhotoGalleryEntity!
}
