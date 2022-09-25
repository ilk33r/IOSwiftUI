//
//  BaseResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

open class BaseResponseModel: BaseModel {
    
    @IOJsonProperty(key: "status")
    public var status: ResponseStatusModel?
}
