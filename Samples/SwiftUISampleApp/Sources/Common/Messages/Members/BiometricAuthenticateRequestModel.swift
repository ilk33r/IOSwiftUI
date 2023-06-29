//
//  BiometricAuthenticateRequestModel.swift
//
//
//  Created by Adnan ilker Ozcan on 29.06.2023.
//

import Foundation
import IOSwiftUICommon

public struct BiometricAuthenticateRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    public init() {
    }
    
    public init(userName: String?) {
        self.userName = userName
    }
}
