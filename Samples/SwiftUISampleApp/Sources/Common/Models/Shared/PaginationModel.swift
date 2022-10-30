//
//  PaginationModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct PaginationModel: BaseModel {
    
    @IOJsonProperty(key: "start")
    public var start: Int?
    
    @IOJsonProperty(key: "count")
    public var count: Int?
    
    @IOJsonProperty(key: "total")
    public var total: Int?
    
    public init() {
    }
    
    public init(start: Int?, count: Int?, total: Int?) {
        self.start = start
        self.count = count
        self.total = total
    }
}
