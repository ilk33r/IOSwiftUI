//
//  PaginationRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class PaginationRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
}
