//
//  StoryItemUIModel.swift
//
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation

public struct StoryItemUIModel: Identifiable {
    
    public let userProfilePicturePublicId: String?
    public let userName: String?
    
    public var id = UUID()
    
    public init(userProfilePicturePublicId: String?, userName: String?) {
        self.userProfilePicturePublicId = userProfilePicturePublicId
        self.userName = userName
    }
}
