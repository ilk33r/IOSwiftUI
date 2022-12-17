// 
//  RegisterProfileNavigationWireframe.swift
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

struct RegisterProfileNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterProfileNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(RegisterRouters.self, .mrzReader(entity: nil)),
            isActive: $navigationState.navigateToMRZReader
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterProfileNavigationState) {
        self.navigationState = navigationState
    }
}
