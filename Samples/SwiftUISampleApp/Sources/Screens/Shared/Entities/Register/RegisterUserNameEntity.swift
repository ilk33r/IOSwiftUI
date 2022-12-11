// 
//  RegisterUserNameEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct RegisterUserNameEntity: IOEntity {
    
    let email: String
    
    public init(email: String) {
        self.email = email
    }
}
