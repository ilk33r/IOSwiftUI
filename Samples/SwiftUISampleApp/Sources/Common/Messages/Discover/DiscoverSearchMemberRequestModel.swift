//
//  DiscoverSearchMemberRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct DiscoverSearchMemberRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "userName")
    public var userName: String!
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel!
    
    public init() {
    }
    
    public init(userName: String, pagination: PaginationModel) {
        self.userName = userName
        self.pagination = pagination
    }
}
