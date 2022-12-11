// 
//  RegisterUserNameNavigationWireframe.swift
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

struct RegisterUserNameNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterUserNameNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(RegisterRouters.self, .createPassword(entity: navigationState.createPasswordEntity)),
            isActive: $navigationState.navigateToCreatePassword
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterUserNameNavigationState) {
        self.navigationState = navigationState
    }
}
