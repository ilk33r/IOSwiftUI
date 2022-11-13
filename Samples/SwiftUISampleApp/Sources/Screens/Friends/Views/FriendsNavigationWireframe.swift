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

struct FriendsNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: FriendsNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        EmptyView()
        /*
        NavigationLink(destination: route(IORouter.sef, .sample(entity: navigationState.sampleEntity)), isActive: $navigationState.navigateToPage) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: FriendsNavigationState) {
        self.navigationState = navigationState
    }
}
