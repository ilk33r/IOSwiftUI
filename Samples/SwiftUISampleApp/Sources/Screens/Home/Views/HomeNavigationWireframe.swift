// 
//  HomeNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

public struct HomeNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: HomeNavigationState
    
    // MARK: - Properties
    
    public var body: some View {
        EmptyView()
        /*
        NavigationLink(destination: PageView(), isActive: $navigationState.navigateToPage) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    public init(navigationState: HomeNavigationState) {
        self.navigationState = navigationState
    }
}
