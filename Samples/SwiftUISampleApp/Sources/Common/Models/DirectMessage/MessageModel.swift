//
//  MessageModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct MessageModel: BaseModel {
    
    @IOJsonProperty(key: "messageID")
    public var messageID: Int?
    
    @IOJsonProperty(key: "message")
    public var message: String?
    
    @IOJsonProperty(key: "messageDate", transformer: IOModelDateTimeTransformer.iso8601())
    public var messageDate: Date?
    
    @IOJsonProperty(key: "isSent")
    public var isSent: Bool?
    
    @IOJsonProperty(key: "userAvatarPublicID")
    public var userAvatarPublicID: String?
    
    public init() {
    }
}
