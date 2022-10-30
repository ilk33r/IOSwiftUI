//
//  InboxModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct InboxModel: BaseModel {
    
    @IOJsonProperty(key: "inboxID")
    public var inboxID: Int?
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    @IOJsonProperty(key: "nameSurname")
    public var nameSurname: String?
    
    @IOJsonProperty(key: "profilePicturePublicID")
    public var profilePicturePublicID: String?
    
    @IOJsonProperty(key: "updateDate", transformer: IOModelDateTimeTransformer(dateFormat: IOModelDateTimeTransformer.iso8601DateFormat))
    public var updateDate: Date?
    
    @IOJsonProperty(key: "unreadMessageCount")
    public var unreadMessageCount: Int?

    @IOJsonProperty(key: "lastMessage")
    public var lastMessage: MessageModel?
    
    public init() {
    }
    
}
