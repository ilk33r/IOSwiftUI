// 
//  DiscoverNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct DiscoverNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: DiscoverNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        Group {
            NavigationLink(
                destination: route(HomeRouters.self, .profile(entity: navigationState.profileEntity)),
                isActive: $navigationState.navigateToProfile
            ) {
                EmptyView()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .fullScreenCover(isPresented: $navigationState.navigateToStories) {
            if let view = navigationState.storiesView {
                view
            } else {
                EmptyView()
            }
        }
        /*
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
    
    init(navigationState: DiscoverNavigationState) {
        self.navigationState = navigationState
    }
}
