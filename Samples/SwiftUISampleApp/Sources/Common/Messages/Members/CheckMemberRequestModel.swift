//
//  CheckMemberRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct CheckMemberRequestModel: BaseRequestModel {

    @IOJsonProperty(key: "email")
    public var email: String!
    
    public init() {
    }
    
    public init(email: String!) {
        self.email = email
    }
}
