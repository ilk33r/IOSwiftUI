// 
//  LoginNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct LoginNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: LoginNavigationState
    
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
    
    init(navigationState: LoginNavigationState) {
        self.navigationState = navigationState
    }
}
