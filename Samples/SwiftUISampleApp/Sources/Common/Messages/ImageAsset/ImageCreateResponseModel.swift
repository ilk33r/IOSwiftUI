//
//  ImageCreateResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct ImageCreateResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "publicID")
    public var publicID: String?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
