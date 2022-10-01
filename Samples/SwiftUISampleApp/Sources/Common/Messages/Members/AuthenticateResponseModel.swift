//
//  AuthenticateResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

final public class AuthenticateResponseModel: BaseResponseModel {
    
    @IOJsonProperty(key: "token")
    public var token: String?
    
    @IOJsonProperty(key: "expire", transformer: IOModelDateTimeTransformer(dateFormat: IOModelDateTimeTransformer.iso8601DateFormat))
    public var expire: Date?
}
