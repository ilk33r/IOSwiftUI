// 
//  ProfileNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct ProfileNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ProfileNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(HomeRouters.self, .chat(entity: navigationState.chatEntity)),
            isActive: $navigationState.navigateToChat
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: route(ProfileRouters.self, .settings(entity: navigationState.settingsEntity)),
            isActive: $navigationState.navigateToSettings
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: route(ProfileRouters.self, .friends(entity: navigationState.friendsEntity)),
            isActive: $navigationState.navigateToFriends
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: ProfileNavigationState) {
        self.navigationState = navigationState
    }
}
