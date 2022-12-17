// 
//  RegisterMRZReaderNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct RegisterMRZReaderNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterMRZReaderNavigationState
    
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
    
    init(navigationState: RegisterMRZReaderNavigationState) {
        self.navigationState = navigationState
    }
}
