// 
//  LoginPasswordNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct LoginPasswordNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: LoginPasswordNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        EmptyView()
        /*
        NavigationLink(
            destination: route(IORouter.self, .sample(entity: navigationState.sampleEntity)),
            isActive: $navigationState.navigateToPage
        ) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: LoginPasswordNavigationState) {
        self.navigationState = navigationState
    }
}
