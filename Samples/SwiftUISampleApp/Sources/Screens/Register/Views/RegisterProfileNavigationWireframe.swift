// 
//  RegisterProfileNavigationWireframe.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct RegisterProfileNavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: RegisterProfileNavigationState
    
    // MARK: - Properties
    
    var body: some View {
        Group {
            NavigationLink(
                destination: route(RegisterRouters.self, .mrzReader(entity: nil)),
                isActive: $navigationState.navigateToMRZReader
            ) {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToCamera) {
            IOImagePickerView(
                sourceType: .camera,
                allowEditing: true
            ) { image in
                navigationState.pickedImage = image
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToPhotoLibrary) {
            IOImagePickerView(
                sourceType: .photoLibrary,
                allowEditing: true
            ) { image in
                navigationState.pickedImage = image
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
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: RegisterProfileNavigationState) {
        self.navigationState = navigationState
    }
}
