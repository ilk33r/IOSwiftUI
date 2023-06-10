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
    @Published var navigateToMap = false
    @Published var navigateToMessage = false
    @Published var navigateToSettings = false
    
    private(set) var chatEntity: ChatEntity?
    private(set) var friendsEntity: FriendsEntity?
    private(set) var galleryView: IORouterView?
    private(set) var mapView: IORouterView?
    private(set) var settingsEntity: SettingsEntity?
    
    // MARK: - Helper Methods
    
    func navigateToChat(chatEntity: ChatEntity?) {
        self.chatEntity = chatEntity
        self.navigateToChat = true
    }
    
    func navigateToFriends(friendsEntity: FriendsEntity?) {
        self.friendsEntity = friendsEntity
        self.navigateToFriends = true
    }
    
    func navigateToGallery(galleryEntity: PhotoGalleryEntity?) {
        self.galleryView = IORouterUtilities.route(
            GalleryRouters.self,
                .gallery(entity: galleryEntity)
        )
        self.navigateToGallery = true
    }
    
    func navigateToSettings(settingsEntity: SettingsEntity?) {
        self.settingsEntity = settingsEntity
        self.navigateToSettings = true
    }
    
    func navigateToMap(userLocationEntity: UserLocationEntity?) {
        self.mapView = IORouterUtilities.route(
            ProfileRouters.self,
            .userLocation(entity: userLocationEntity)
        )
        self.navigateToMap = true
    }
}
