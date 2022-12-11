// 
//  RegisterNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct RegisterNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        EmptyView()
        NavigationLink(
            destination: route(RegisterRouters.self, .userName(entity: navigationState.userNameEntity)),
            isActive: $navigationState.navigateToUserName
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterNavigationState) {
        self.navigationState = navigationState
    }
}
