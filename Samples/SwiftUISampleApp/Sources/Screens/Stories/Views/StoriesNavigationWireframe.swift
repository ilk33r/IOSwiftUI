// 
//  StoriesNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct StoriesNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: StoriesNavigationState
    
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
    
    init(navigationState: StoriesNavigationState) {
        self.navigationState = navigationState
    }
}
