//
//  ResponseStatusModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

public struct ResponseStatusModel: BaseModel {
    
    @IOJsonProperty(key: "code", defaultValue: 0)
    public var code: Int!
    
    @IOJsonProperty(key: "detailedMessage")
    public var detailedMessage: String?
    
    @IOJsonProperty(key: "message")
    public var message: String?
    
    @IOJsonProperty(key: "success", defaultValue: false)
    public var success: Bool!
    
    public init() {
    }
}
