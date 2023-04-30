// 
//  DiscoverNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct DiscoverNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: DiscoverNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(
                HomeRouters.self,
                .profile(
                    entity: ProfileEntity(
                        navigationBarHidden: true,
                        userName: navigationState.userName
                    )
                )
            ),
            isActive: $navigationState.navigateToProfile
        ) {
            EmptyView()
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: DiscoverNavigationState) {
        self.navigationState = navigationState
    }
}
