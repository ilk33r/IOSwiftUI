//
//  ChatItemUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import SwiftUI

struct ChatItemUIModel: Identifiable {
    
    let imagePublicID: String?
    let chatMessage: String
    let isLastMessage: Bool
    let isSend: Bool
    let messageTime: String
    let id: Int
    
    init(
        id: Int,
        imagePublicID: String?,
        chatMessage: String,
        isLastMessage: Bool,
        isSend: Bool,
        messageTime: String
    ) {
        self.id = id
        self.imagePublicID = imagePublicID
        self.chatMessage = chatMessage
        self.isLastMessage = isLastMessage
        self.isSend = isSend
        self.messageTime = messageTime
    }
}
