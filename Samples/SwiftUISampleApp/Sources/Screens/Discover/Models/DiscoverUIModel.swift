//
//  DiscoverUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import SwiftUI

struct DiscoverUIModel: Identifiable {
    
    let imagePublicId: String
    let userName: String
    let userNameAndSurname: String
    let userAvatarPublicId: String
    let messageTime: String
    let id = UUID()
    
    init(
        imagePublicId: String,
        userName: String,
        userNameAndSurname: String,
        userAvatarPublicId: String,
        messageTime: String
    ) {
        self.imagePublicId = imagePublicId
        self.userName = userName
        self.userNameAndSurname = userNameAndSurname
        self.userAvatarPublicId = userAvatarPublicId
        self.messageTime = messageTime
    }
}
