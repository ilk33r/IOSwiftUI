//
//  SendOTPResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct SendOTPResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    public var otpTimeout: Int?
    
    public init() {
        self._status = IOJsonProperty<ResponseStatusModel>(key: "status")
    }
}
