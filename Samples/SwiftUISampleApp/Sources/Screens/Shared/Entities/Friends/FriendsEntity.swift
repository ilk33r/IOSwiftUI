// 
//  FriendsEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

public struct FriendsEntity: IOEntity {
    
    public let friends: MemberFriendsResponseModel
    
    public init(friends: MemberFriendsResponseModel) {
        self.friends = friends
    }
}
