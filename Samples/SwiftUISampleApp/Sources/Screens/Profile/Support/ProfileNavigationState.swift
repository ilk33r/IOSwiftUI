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
    
    @Published public var navigateToChat = false
    @Published public var navigateToFriends = false
    @Published public var navigateToGallery = false
    @Published public var navigateToMessage = false
    @Published public var navigateToSettings = false
    
    var chatEntity: ChatEntity!
    var friendsEntity: FriendsEntity!
    var galleryEntity: PhotoGalleryEntity!
    var settingsEntity: SettingsEntity!
}
