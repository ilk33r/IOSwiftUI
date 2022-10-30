//
//  SendMessageRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct SendMessageRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "toMemberID")
    public var toMemberID: Int!
    
    @IOJsonProperty(key: "encryptedMessage")
    public var encryptedMessage: String?
    
    public init() {
    }
    
    public init(toMemberID: Int!, encryptedMessage: String?) {
        self.toMemberID = toMemberID
        self.encryptedMessage = encryptedMessage
    }
}
