// 
//  RegisterNFCReaderViewNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct RegisterNFCReaderViewNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterNFCReaderViewNavigationState
    
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
    
    init(navigationState: RegisterNFCReaderViewNavigationState) {
        self.navigationState = navigationState
    }
}
