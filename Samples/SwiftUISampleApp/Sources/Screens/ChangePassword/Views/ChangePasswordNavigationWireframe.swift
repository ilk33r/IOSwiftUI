// 
//  ChangePasswordNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct ChangePasswordNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ChangePasswordNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        Group {
            NavigationLink(
                destination: route(ProfileRouters.self, .changePassword(entity: nil)),
                isActive: $navigationState.navigateToChangePassword
            ) {
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
    
    init(navigationState: ChangePasswordNavigationState) {
        self.navigationState = navigationState
    }
}
