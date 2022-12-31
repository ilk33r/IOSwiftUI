//
//  MemberPairFaceIDRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberPairFaceIDRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "authenticationKey")
    public var authenticationKey: String?
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    public init(authenticationKey: String) {
        self.authenticationKey = authenticationKey
    }
}
