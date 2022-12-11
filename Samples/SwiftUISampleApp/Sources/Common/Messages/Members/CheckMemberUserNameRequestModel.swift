//
//  CheckMemberUserNameRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct CheckMemberUserNameRequestModel: BaseRequestModel {

    @IOJsonProperty(key: "userName")
    public var userName: String!
    
    public init() {
    }
    
    public init(userName: String!) {
        self.userName = userName
    }
}
