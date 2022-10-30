//
//  HandshakeResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

public struct HandshakeResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "keyID")
    public var keyID: String?
    
    @IOJsonProperty(key: "publicKeyExponent")
    public var publicKeyExponent: String?
    
    @IOJsonProperty(key: "publicKeyModulus")
    public var publicKeyModulus: String?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
