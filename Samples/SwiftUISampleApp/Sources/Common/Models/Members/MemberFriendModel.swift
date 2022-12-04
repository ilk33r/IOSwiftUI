//
//  MemberFriendModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberFriendModel: BaseModel {
    
    @IOJsonProperty(key: "id")
    public var id: Int?
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    @IOJsonProperty(key: "userNameAndSurname")
    public var userNameAndSurname: String?
    
    @IOJsonProperty(key: "locationName")
    public var locationName: String?
    
    @IOJsonProperty(key: "locationLatitude")
    public var locationLatitude: Double?
    
    @IOJsonProperty(key: "locationLongitude")
    public var locationLongitude: Double?
    
    @IOJsonProperty(key: "profilePicturePublicId")
    public var profilePicturePublicId: String?
    
    public init() {
        
    }
}
