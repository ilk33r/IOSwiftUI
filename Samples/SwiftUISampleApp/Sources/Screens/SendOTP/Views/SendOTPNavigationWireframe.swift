// 
//  SendOTPNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct SendOTPNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SendOTPNavigationState
    
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
    
    init(navigationState: SendOTPNavigationState) {
        self.navigationState = navigationState
    }
}
