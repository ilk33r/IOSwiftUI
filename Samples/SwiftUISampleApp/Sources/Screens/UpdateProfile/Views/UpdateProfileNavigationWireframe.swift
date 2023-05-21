// 
//  UpdateProfileNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct UpdateProfileNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: UpdateProfileNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        Group {
            NavigationLink(
                destination: route(ProfileRouters.self, .updateProfile(entity: nil)),
                isActive: $navigationState.navigateToUpdateProfile
            ) {
                EmptyView()
            }
        }
        .sheet(isPresented: $navigationState.showLocationSelection) {
            if let locationView = navigationState.locationView {
                locationView
            } else {
                EmptyView()
            }
        }
        .sheet(
            isPresented: $navigationState.showSendOTP,
            onDismiss: {
                navigationState.sendOTPDismissed()
            }, content: {
                if let sendOTPView = navigationState.sendOTPView {
                    sendOTPView
                } else {
                    EmptyView()
                }
            }
        )
        /*
        .fullScreenCover(isPresented: $navigationState.navigateToEditProfile) {
            if let view = navigationState.editProfileView {
                view
            } else {
                EmptyView()
            }
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: UpdateProfileNavigationState) {
        self.navigationState = navigationState
    }
}
