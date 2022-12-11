// 
//  RegisterCreatePasswordEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct RegisterCreatePasswordEntity: IOEntity {
    
    public let email: String
    public let password: String
    public let userName: String
    public let validate: Bool
    
    public init(
        email: String,
        password: String,
        userName: String,
        validate: Bool
    ) {
        self.email = email
        self.password = password
        self.userName = userName
        self.validate = validate
    }
}
