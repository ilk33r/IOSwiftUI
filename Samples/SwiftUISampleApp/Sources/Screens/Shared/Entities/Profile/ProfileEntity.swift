// 
//  ProfileEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

public struct ProfileEntity: IOEntity {
    
    public let navigationBarHidden: Bool
    public let userName: String?
    public let fromDeepLink: Bool
    public let member: MemberModel?
    
    public init(
        navigationBarHidden: Bool,
        userName: String?,
        fromDeepLink: Bool,
        member: MemberModel?
    ) {
        self.navigationBarHidden = navigationBarHidden
        self.userName = userName
        self.fromDeepLink = fromDeepLink
        self.member = member
    }
}
