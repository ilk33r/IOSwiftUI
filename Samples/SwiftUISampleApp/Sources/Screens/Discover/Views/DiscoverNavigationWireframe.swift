// 
//  DiscoverNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct DiscoverNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: DiscoverNavigationState
    
    // MARK: - Properties
    
    var linkBody: some View {
        NavigationLink(
            destination: ProfileView(entity: ProfileEntity(userName: self.navigationState.userName)),
            isActive: $navigationState.navigateToProfile
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: DiscoverNavigationState) {
        self.navigationState = navigationState
    }
}
