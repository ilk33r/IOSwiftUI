//
//  AuthenticateRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import Foundation
import IOSwiftUICommon

final public class AuthenticateRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "email")
    public var email: String?
    
    @IOJsonProperty(key: "password")
    public var password: String?
}
