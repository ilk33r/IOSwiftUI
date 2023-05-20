//
//  ChatPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.05.2023.
//

import Foundation

#if DEBUG
struct ChatPreviewData {
    
    // MARK: - Data
    
    static var previewData = [
        ChatItemUIModel(
            id: 0,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            id: 1,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: true,
            messageTime: "17 min ago"
        ),
        ChatItemUIModel(
            id: 2,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: true,
            messageTime: "17 min ago"
        ),
        ChatItemUIModel(
            id: 3,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: false,
            messageTime: "21 min ago"
        ),
        ChatItemUIModel(
            id: 4,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            id: 5,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: true,
            messageTime: "17 min ago"
        ),
        ChatItemUIModel(
            id: 6,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: true,
            messageTime: "17 min ago"
        ),
        ChatItemUIModel(
            id: 7,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: false,
            messageTime: "21 min ago"
        ),
        ChatItemUIModel(
            id: 8,
            imagePublicID: "",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: true,
            isSend: true,
            messageTime: "1 min ago"
        )
    ]
    
    static var previewDataReceivedCell = ChatItemUIModel(
        id: 0,
        imagePublicID: "",
        chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
        isLastMessage: false,
        isSend: false,
        messageTime: "16 min ago"
    )
    
    static var previewDataSendCell = ChatItemUIModel(
        id: 0,
        imagePublicID: "",
        chatMessage: "A fast 50mm like f1.8 would help with the bokeh. I’ve been using primes as they tend to get a bit sharper images.",
        isLastMessage: false,
        isSend: true,
        messageTime: "16 min ago"
    )
}
#endif
