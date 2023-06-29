//
//  BiometricAuthenticateResponseModel.swift
//
//
//  Created by Adnan ilker Ozcan on 29.06.2023.
//

import Foundation
import IOSwiftUICommon

public struct BiometricAuthenticateResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "biometricToken")
    public var biometricToken: String?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
