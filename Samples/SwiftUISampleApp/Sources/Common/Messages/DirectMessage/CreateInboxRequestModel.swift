//
//  CreateInboxRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct CreateInboxRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "toMemberID")
    public var toMemberID: Int?
    
    public init() {
    }
    
    public init(toMemberID: Int?) {
        self.toMemberID = toMemberID
    }
}
