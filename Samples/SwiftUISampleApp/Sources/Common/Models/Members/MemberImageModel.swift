//
//  MemberImageModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct MemberImageModel: BaseModel {
    
    @IOJsonProperty(key: "imageId")
    public var imageId: Int?
    
    @IOJsonProperty(key: "memberId")
    public var memberId: Int?
    
    @IOJsonProperty(key: "publicId")
    public var publicId: String?
    
    @IOJsonProperty(key: "createDate", transformer: IOModelDateTimeTransformer.iso8601())
    public var createDate: Date?
    
    public init() {
    }
}
