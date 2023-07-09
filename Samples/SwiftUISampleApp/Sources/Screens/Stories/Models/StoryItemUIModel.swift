//
//  StoryItemUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 8.07.2023.
//

import Foundation

struct StoryItemUIModel: Identifiable {
    
    let relativeDate: String
    let userNameAndSurname: String
    let userProfilePicturePublicId: String?
    let publicId: String?
    
    var id = UUID()
    
    init(
        relativeDate: String,
        userNameAndSurname: String,
        userProfilePicturePublicId: String?,
        publicId: String?
    ) {
        self.relativeDate = relativeDate
        self.userNameAndSurname = userNameAndSurname
        self.userProfilePicturePublicId = userProfilePicturePublicId
        self.publicId = publicId
    }
}
