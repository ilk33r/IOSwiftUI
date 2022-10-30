//
//  DiscoverImageModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct DiscoverImageModel: BaseModel {
    
    @IOJsonProperty(key: "memberId")
    public var memberId: Int?
    
    @IOJsonProperty(key: "publicId")
    public var publicId: String?
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    @IOJsonProperty(key: "userNameAndSurname")
    public var userNameAndSurname: String?
    
    @IOJsonProperty(key: "userProfilePicturePublicId")
    public var userProfilePicturePublicId: String?
    
    @IOJsonProperty(key: "createDate", transformer: IOModelDateTimeTransformer(dateFormat: IOModelDateTimeTransformer.iso8601DateFormat))
    public var createDate: Date?
    
    public init() {
    }
}
