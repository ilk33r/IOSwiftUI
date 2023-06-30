//
//  AuthenticateWithBiometricRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.06.2023.
//

import Foundation
import IOSwiftUICommon

public struct AuthenticateWithBiometricRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    @IOJsonProperty(key: "biometricPassword")
    public var biometricPassword: String?
    
    public init() {
    }
    
    public init(userName: String?, biometricPassword: String?) {
        self.userName = userName
        self.biometricPassword = biometricPassword
    }
}
