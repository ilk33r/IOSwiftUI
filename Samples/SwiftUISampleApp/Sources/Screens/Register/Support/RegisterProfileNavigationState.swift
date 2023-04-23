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
    @Published var pickedImage: UIImage?
    
    // MARK: - Privates
    
    private var sendOTPView: IORouterView?
    
    // MARK: - Helper Methods
    
    func createSendOTPView(showSendOTP: Binding<Bool>, isOTPValidated: Binding<Bool>, phoneNumber: String) -> IORouterView {
        if let sendOTPView = self.sendOTPView {
            return sendOTPView
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
        
        return self.sendOTPView!
    }
    
    func sendOTPDismissed() {
        self.sendOTPView = nil
    }
}
