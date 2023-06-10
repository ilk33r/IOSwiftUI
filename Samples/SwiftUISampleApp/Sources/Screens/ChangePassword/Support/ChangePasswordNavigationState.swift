// 
//  ChangePasswordNavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class ChangePasswordNavigationState: IONavigationState {
    
    // MARK: - Properties
    
    @Published var navigateToChangePassword = false
    @Published var showSendOTP = false
    
    private(set) var sendOTPView: IORouterView?
    
    // MARK: - Helper Methods
    
    func navigateToSendOTPView(showSendOTP: Binding<Bool>, isOTPValidated: Binding<Bool>, phoneNumber: String) {
        if self.sendOTPView != nil {
            self.showSendOTP = true
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
        self.sendOTPView = nil
    }
}
