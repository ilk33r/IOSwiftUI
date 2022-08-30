//
//  ChatItemUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import SwiftUI

struct ChatItemUIModel: Identifiable {
    
    let image: Image
    let chatMessage: String
    let isLastMessage: Bool
    let isSend: Bool
    let messageTime: String
    let id = UUID()
    
    init(
        image: Image,
        chatMessage: String,
        isLastMessage: Bool,
        isSend: Bool,
        messageTime: String
    ) {
        self.image = image
        self.chatMessage = chatMessage
        self.isLastMessage = isLastMessage
        self.isSend = isSend
        self.messageTime = messageTime
    }
}
