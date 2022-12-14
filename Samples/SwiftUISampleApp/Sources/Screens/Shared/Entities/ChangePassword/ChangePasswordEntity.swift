// 
//  ChangePasswordEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct ChangePasswordEntity: IOEntity {
    
    public let phoneNumber: String
    
    public init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}
