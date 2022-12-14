//
//  InboxResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct InboxResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "inboxes")
    public var inboxes: [InboxModel]?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
