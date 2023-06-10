// 
//  UpdateProfileNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class UpdateProfileNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToUpdateProfile = false
    @Published var showLocationSelection = false
    @Published var showSendOTP = false
    
    private(set) var locationView: IORouterView?
    private(set) var sendOTPView: IORouterView?
    
    // MARK: - Helper Methods
    
    func showLocationSelection(
        isPresented: Binding<Bool>,
        locationName: Binding<String>,
        locationLatitude: Binding<Double?>,
        locationLongitude: Binding<Double?>
    ) {
        self.locationView = IORouterUtilities.route(
            ProfileRouters.self,
            .userLocation(
                entity: UserLocationEntity(
                    isEditable: true,
                    isPresented: isPresented,
                    locationName: locationName,
                    locationLatitude: locationLatitude,
                    locationLongitude: locationLongitude
                )
            )
        )
        
        self.showLocationSelection = true
    }
    
    func createSendOTPView(showSendOTP: Binding<Bool>, isOTPValidated: Binding<Bool>, phoneNumber: String) {
        if self.sendOTPView != nil {
            self.showSendOTP = true
            return
        }
        
        self.sendOTPView = IORouterUtilities.route(
            OTPRouters.self,
            .sendOTP(
                entity: SendOTPEntity(
                    isPresented: showSendOTP,
                    isOTPValidated: isOTPValidated,
                    phoneNumber: phoneNumber
                )
            )
        )
        
        self.showSendOTP = true
    }
    
    func sendOTPDismissed() {
        self.showSendOTP = false
        self.sendOTPView = nil
    }
}
