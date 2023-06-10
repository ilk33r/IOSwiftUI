// 
//  RegisterProfileNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class RegisterProfileNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToCamera = false
    @Published var navigateToMRZReader = false
    @Published var navigateToPhotoLibrary = false
    @Published var showLocationSelection = false
    @Published var showSendOTP = false
    @Published var pickedImage: UIImage?
    
    private(set) var locationView: IORouterView?
    private(set) var sendOTPView: IORouterView?
    
    // MARK: - Privates
    
    // MARK: - Helper Methods
    
    func navigateToLocationSelection(
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
    
    func navigateToSendOTPView(
        showSendOTP: Binding<Bool>,
        isOTPValidated: Binding<Bool>,
        phoneNumber: String
    ) {
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
