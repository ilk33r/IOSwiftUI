//
//  GetMessagesResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct GetMessagesResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "messages")
    public var messages: [MessageModel]?
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
