//
//  SendOTPRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct SendOTPRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "phoneNumber")
    public var phoneNumber: String?
    
    public init() {
        
    }
    
    public init(phoneNumber: String?) {
        self.phoneNumber = phoneNumber
    }
}
