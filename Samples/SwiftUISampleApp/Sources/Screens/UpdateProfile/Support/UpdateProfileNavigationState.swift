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
    
//    @Published private(set) var navigateToPage: Bool = false
    
    // MARK: - Privates
    
    private var sendOTPView: IORouterView?
    
    // MARK: - Helper Methods
    
    func createSendOTPView(showSendOTP: Binding<Bool>, phoneNumber: String) -> IORouterView {
        if let sendOTPView = self.sendOTPView {
            return sendOTPView
        }
        
        self.sendOTPView = IORouterUtilities.route(
            OTPRouters.self,
            .sendOTP(
                entity: SendOTPEntity(
                    isPresented: showSendOTP,
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
