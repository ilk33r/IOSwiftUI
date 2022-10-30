//
//  GenericResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct GenericResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    // MARK: - Base Properties
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
