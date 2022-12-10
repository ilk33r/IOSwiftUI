// 
//  FriendsNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct FriendsNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: FriendsNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(HomeRouters.self, .profile(entity: navigationState.profileEntity)),
            isActive: $navigationState.navigateToProfile
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: FriendsNavigationState) {
        self.navigationState = navigationState
    }
}
