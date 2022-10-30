//
//  AuthenticateRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import Foundation
import IOSwiftUICommon

public struct AuthenticateRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "email")
    public var email: String?
    
    @IOJsonProperty(key: "password")
    public var password: String?
    
    public init() {
    }
    
    public init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
}
