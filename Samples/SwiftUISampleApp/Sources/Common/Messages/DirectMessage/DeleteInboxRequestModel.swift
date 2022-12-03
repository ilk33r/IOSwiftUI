//
//  DeleteInboxRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct DeleteInboxRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "inboxID")
    public var inboxID: Int!
    
    public init() {
        
    }
    
    public init(inboxID: Int!) {
        self.inboxID = inboxID
    }
}
