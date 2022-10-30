//
//  PaginationRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct PaginationRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
    
    public init() {
    }
    
    public init(pagination: PaginationModel?) {
        self.pagination = pagination
    }
}
