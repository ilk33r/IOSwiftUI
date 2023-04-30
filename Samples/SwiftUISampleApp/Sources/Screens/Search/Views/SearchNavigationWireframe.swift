// 
//  SearchNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct SearchNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SearchNavigationState
    
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
    
    init(navigationState: SearchNavigationState) {
        self.navigationState = navigationState
    }
}
