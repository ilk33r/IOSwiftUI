//
//  MemberGetResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class MemberGetResponseModel: BaseResponseModel {
    
    @IOJsonProperty(key: "member")
    public var member: MemberModel?
}
