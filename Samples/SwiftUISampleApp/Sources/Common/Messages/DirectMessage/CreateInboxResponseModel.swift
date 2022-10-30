//
//  CreateInboxResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct CreateInboxResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "inbox")
    public var inbox: InboxModel?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
