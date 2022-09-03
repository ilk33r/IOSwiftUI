//
//  DiscoverUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import SwiftUI

struct DiscoverUIModel: Identifiable {
    
    let image: Image
    let userName: String
    let userNameAndSurname: String
    let userAvatar: Image
    let messageTime: String
    let id = UUID()
    
    init(
        image: Image,
        userName: String,
        userNameAndSurname: String,
        userAvatar: Image,
        messageTime: String
    ) {
        self.image = image
        self.userName = userName
        self.userNameAndSurname = userNameAndSurname
        self.userAvatar = userAvatar
        self.messageTime = messageTime
    }
}
