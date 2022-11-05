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

struct SettingsNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SettingsNavigationState
    
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
    
    init(navigationState: SettingsNavigationState) {
        self.navigationState = navigationState
    }
}
