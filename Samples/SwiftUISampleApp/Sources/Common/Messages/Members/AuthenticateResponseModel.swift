//
//  AuthenticateResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct AuthenticateResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "token")
    public var token: String?
    
    @IOJsonProperty(key: "expire", transformer: IOModelDateTimeTransformer.iso8601())
    public var expire: Date?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
