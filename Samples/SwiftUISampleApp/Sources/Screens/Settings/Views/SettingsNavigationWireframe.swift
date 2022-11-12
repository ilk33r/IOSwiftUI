// 
//  SettingsNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct SettingsNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SettingsNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(destination: route(ProfileRouters.self, .updateProfile(entity: navigationState.updateProfileEntity)), isActive: $navigationState.navigateToUpdateProfile) {
            EmptyView()
        }
        NavigationLink(destination: route(ProfileRouters.self, .changePassword(entity: ChangePasswordEntity())), isActive: $navigationState.navigateToChangePassword) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: SettingsNavigationState) {
        self.navigationState = navigationState
    }
}
