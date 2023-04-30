// 
//  HomeNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

public struct HomeNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: HomeNavigationState
    
    // MARK: - Properties
    
    public var body: some View {
        EmptyView()
        Group {
            NavigationLink(
                destination: route(HomeRouters.self, .profile(entity: nil)),
                isActive: $navigationState.navigateToProfile
            ) {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToCamera) {
            if let cameraView = navigationState.cameraView {
                cameraView
            } else {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToPhotoLibrary) {
            if let photoLibraryView = navigationState.photoLibraryView {
                photoLibraryView
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
    
    public init(navigationState: HomeNavigationState) {
        self.navigationState = navigationState
    }
}
