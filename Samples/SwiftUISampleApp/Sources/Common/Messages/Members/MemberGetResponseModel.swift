//
//  MemberGetResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberGetResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "member")
    public var member: MemberModel?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
