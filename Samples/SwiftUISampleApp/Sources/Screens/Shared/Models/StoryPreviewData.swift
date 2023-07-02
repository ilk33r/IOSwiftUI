//
//  StoryPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation

#if DEBUG
struct StoryPreviewData {
    
    static let previewData = [
        StoryItemUIModel(
            userProfilePicturePublicId: nil,
            userName: "ilkerozcan.jpeg"
        ),
        StoryItemUIModel(
            userProfilePicturePublicId: nil,
            userName: "Lorem"
        ),
        StoryItemUIModel(
            userProfilePicturePublicId: nil,
            userName: "Ipsum"
        ),
        StoryItemUIModel(
            userProfilePicturePublicId: nil,
            userName: "Dolor"
        ),
        StoryItemUIModel(
            userProfilePicturePublicId: nil,
            userName: "Sit"
        ),
        StoryItemUIModel(
            userProfilePicturePublicId: nil,
            userName: "Amet"
        )
    ]
    
    static let previewDataCell = StoryItemUIModel(
        userProfilePicturePublicId: nil,
        userName: "ilkerozcan.jpeg"
    )
}
#endif
