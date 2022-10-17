//
//  SendMessageRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class SendMessageRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "toMemberID")
    public var toMemberID: Int!
    
    @IOJsonProperty(key: "encryptedMessage")
    public var encryptedMessage: String?
}
