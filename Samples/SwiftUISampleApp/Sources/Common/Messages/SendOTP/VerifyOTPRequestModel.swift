//
//  VerifyOTPRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct VerifyOTPRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "phoneNumber")
    public var phoneNumber: String?
    
    @IOJsonProperty(key: "otp")
    public var otp: String?
    
    public init() {
        
    }
    
    public init(phoneNumber: String?, otp: String?) {
        self.phoneNumber = phoneNumber
        self.otp = otp
    }
}
