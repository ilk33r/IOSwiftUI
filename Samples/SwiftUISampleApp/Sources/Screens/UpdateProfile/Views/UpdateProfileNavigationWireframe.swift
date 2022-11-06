// 
//  UpdateProfileNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct UpdateProfileNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: UpdateProfileNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        EmptyView()
        /*
        NavigationLink(destination: PageView(), isActive: $navigationState.navigateToPage) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: UpdateProfileNavigationState) {
        self.navigationState = navigationState
    }
}
