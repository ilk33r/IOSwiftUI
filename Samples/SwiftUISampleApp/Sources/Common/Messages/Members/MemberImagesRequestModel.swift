//
//  MemberImagesRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class MemberImagesRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "userName")
    public var userName: String?
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
}
