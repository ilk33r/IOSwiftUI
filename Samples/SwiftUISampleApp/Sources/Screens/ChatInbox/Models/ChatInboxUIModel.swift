//
//  ChatInboxUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation

struct ChatInboxUIModel: Identifiable {
    
    let id = UUID()
    let index: Int
    let profilePicturePublicId: String
    let nameSurname: String
    let lastMessage: String
    
    init(index: Int, profilePicturePublicId: String, nameSurname: String, lastMessage: String) {
        self.index = index
        self.profilePicturePublicId = profilePicturePublicId
        self.nameSurname = nameSurname
        self.lastMessage = lastMessage
    }
}
