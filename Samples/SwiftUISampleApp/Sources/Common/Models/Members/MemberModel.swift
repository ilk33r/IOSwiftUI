//
//  MemberModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct MemberModel: BaseModel {
    
    @IOJsonProperty(key: "id")
    public var id: Int?
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    @IOJsonProperty(key: "birthDate", transformer: IOModelDateTimeTransformer(dateFormat: IOModelDateTimeTransformer.iso8601DateFormat))
    public var birthDate: Date?
    
    @IOJsonProperty(key: "email")
    public var email: String?
    
    @IOJsonProperty(key: "name")
    public var name: String?
    
    @IOJsonProperty(key: "surname")
    public var surname: String?
    
    @IOJsonProperty(key: "locationName")
    public var locationName: String?
    
    @IOJsonProperty(key: "locationLatitude")
    public var locationLatitude: Double?
    
    @IOJsonProperty(key: "locationLongitude")
    public var locationLongitude: Double?
    
    @IOJsonProperty(key: "profilePicturePublicId")
    public var profilePicturePublicId: String?
    
    @IOJsonProperty(key: "IsFollowing", defaultValue: false)
    public var isFollowing: Bool!
    
    public init() {
    }
}
