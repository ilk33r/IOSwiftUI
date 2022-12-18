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
import SwiftUISampleAppScreensShared

struct RegisterMRZReaderNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterMRZReaderNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        NavigationLink(
            destination: route(RegisterRouters.self, .nfcReader(entity: navigationState.nfcReaderEntity)),
            isActive: $navigationState.navigateToNFCReader
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterMRZReaderNavigationState) {
        self.navigationState = navigationState
    }
}
