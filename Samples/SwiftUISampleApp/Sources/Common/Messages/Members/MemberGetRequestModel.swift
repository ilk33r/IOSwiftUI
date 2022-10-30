//
//  MemberGetRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberGetRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "userName", defaultValue: nil)
    public var userName: String?
    
    public init() {
    }
    
    public init(userName: String?) {
        self.userName = userName
    }
}
