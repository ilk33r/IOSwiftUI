// 
//  RegisterCreatePasswordNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct RegisterCreatePasswordNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterCreatePasswordNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(RegisterRouters.self, .createPassword(entity: navigationState.createPasswordEntity)),
            isActive: $navigationState.navigateToCreatePassword
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: route(RegisterRouters.self, .profile(entity: navigationState.profileEntity)),
            isActive: $navigationState.navigateToProfile
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterCreatePasswordNavigationState) {
        self.navigationState = navigationState
    }
}
