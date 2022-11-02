//
//  GetMessagesRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct GetMessagesRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
    
    @IOJsonProperty(key: "inboxID")
    public var inboxID: Int?
    
    public init() {
    }
    
    public init(pagination: PaginationModel?, inboxID: Int?) {
        self.pagination = pagination
        self.inboxID = inboxID
    }
}
