// 
//  ChatInboxNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct ChatInboxNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ChatInboxNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(HomeRouters.self, .chat(entity: navigationState.chatEntity)),
            isActive: $navigationState.navigateToChat
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: ChatInboxNavigationState) {
        self.navigationState = navigationState
    }
}
