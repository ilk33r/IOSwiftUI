// 
//  FriendsMapEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.06.2023.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

public struct FriendsMapEntity: IOEntity {
    
    public let friends: MemberFriendsResponseModel
    
    public init(friends: MemberFriendsResponseModel) {
        self.friends = friends
    }
}
