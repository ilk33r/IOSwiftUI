// 
//  ProfileNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct ProfileNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ProfileNavigationState
    
    // MARK: - Properties
    
    var linkBody: some View {
        EmptyView()
        /*
        NavigationLink(destination: PageView(), isActive: $navigationState.navigateToPage) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: ProfileNavigationState) {
        self.navigationState = navigationState
    }
}
