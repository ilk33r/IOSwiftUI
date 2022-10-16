// 
//  ProfileEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct ProfileEntity: IOEntity {
    
    public let userName: String?
    
    public init(userName: String?) {
        self.userName = userName
    }
}
