//
//  MemberFollowingRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberFollowingRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "memberID")
    public var memberID: Int!
    
    public init() {
    }
    
    public init(memberID: Int!) {
        self.memberID = memberID
    }
}
