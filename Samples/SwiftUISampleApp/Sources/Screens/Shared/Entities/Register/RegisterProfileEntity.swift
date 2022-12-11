// 
//  RegisterProfileEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct RegisterProfileEntity: IOEntity {
    
    public let email: String
    public let password: String
    public let userName: String
    
    public init(
        email: String,
        password: String,
        userName: String
    ) {
        self.email = email
        self.password = password
        self.userName = userName
    }
}
