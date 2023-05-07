// 
//  LoginPasswordEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct LoginPasswordEntity: IOEntity {
    
    public let email: String?
    
    public init(email: String?) {
        self.email = email
    }
}
