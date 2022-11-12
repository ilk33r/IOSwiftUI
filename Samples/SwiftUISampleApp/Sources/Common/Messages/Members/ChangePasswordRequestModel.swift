//
//  ChangePasswordRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct ChangePasswordRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "oldPassword")
    public var oldPassword: String?
    
    @IOJsonProperty(key: "newPassword")
    public var newPassword: String?
    
    public init() {
    }
    
    public init(oldPassword: String?, newPassword: String?) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
    }
}
