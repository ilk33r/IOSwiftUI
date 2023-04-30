// 
//  ProfileEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation

public struct ProfileEntity: IOEntity {
    
    public let navigationBarHidden: Bool
    public let userName: String?
    
    public init(
        navigationBarHidden: Bool,
        userName: String?
    ) {
        self.navigationBarHidden = navigationBarHidden
        self.userName = userName
    }
}
