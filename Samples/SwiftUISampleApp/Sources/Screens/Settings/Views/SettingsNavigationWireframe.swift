// 
//  SettingsNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct SettingsNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: SettingsNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        Group {
            NavigationLink(
                destination: route(ProfileRouters.self, .updateProfile(entity: navigationState.updateProfileEntity)),
                isActive: $navigationState.navigateToUpdateProfile
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: route(ProfileRouters.self, .changePassword(entity: navigationState.changePasswordEntity)),
                isActive: $navigationState.navigateToChangePassword
            ) {
                EmptyView()
            }
            NavigationLink(
                destination: route(ProfileRouters.self, .web(entity: navigationState.webEntity)),
                isActive: $navigationState.navigateToWeb
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
    
    init(navigationState: SettingsNavigationState) {
        self.navigationState = navigationState
    }
}
