// 
//  ChatNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct ChatNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ChatNavigationState
    
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
    
    init(navigationState: ChatNavigationState) {
        self.navigationState = navigationState
    }
}
