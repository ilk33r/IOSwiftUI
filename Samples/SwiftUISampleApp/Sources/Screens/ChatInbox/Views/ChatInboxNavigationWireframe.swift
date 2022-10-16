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

struct ChatInboxNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ChatInboxNavigationState
    
    // MARK: - Properties
    
    var linkBody: some View {
        /*NavigationLink(
            destination: ChatView(entity: ChatEntity()),
            isActive: $navigationState.navigateToChat
        ) {
            EmptyView()
        }
         */
        EmptyView()
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: ChatInboxNavigationState) {
        self.navigationState = navigationState
    }
}
