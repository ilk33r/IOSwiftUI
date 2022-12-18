// 
//  ProfileNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

final public class ProfileNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToChat = false
    @Published var navigateToFriends = false
    @Published var navigateToGallery = false
    @Published var navigateToMessage = false
    @Published var navigateToSettings = false
    
    var chatEntity: ChatEntity!
    var friendsEntity: FriendsEntity!
    var galleryEntity: PhotoGalleryEntity!
    var settingsEntity: SettingsEntity!
}
