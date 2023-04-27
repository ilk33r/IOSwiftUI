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
        EmptyView()
        /*
        Group {
            NavigationLink(
                destination: route(IORouter.self, .sample(entity: navigationState.sampleEntity)),
                isActive: $navigationState.navigateToPage
            ) {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToEditProfile) {
            if let view = navigationState.editProfileView {
                view
            } else {
                EmptyView()
            }
        }
        .sheet(isPresented: $navigationState.navigateToMap) {
            if let mapView = navigationState.mapView {
                mapView
            } else {
                EmptyView()
            }
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterMRZReaderNavigationState) {
        self.navigationState = navigationState
    }
}
