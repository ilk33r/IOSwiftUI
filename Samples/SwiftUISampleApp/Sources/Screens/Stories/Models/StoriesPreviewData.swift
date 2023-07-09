// 
//  StoriesPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import Foundation
import SwiftUISampleAppCommon

#if DEBUG
struct StoriesPreviewData {
    
    // MARK: - Data
    
    static var previewData = getStories()
    static var itemPreviewData = [
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "Lorem", userProfilePicturePublicId: nil, publicId: nil),
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "Ipsum", userProfilePicturePublicId: nil, publicId: nil),
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "Dolor", userProfilePicturePublicId: nil, publicId: nil),
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "Sit", userProfilePicturePublicId: nil, publicId: nil),
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "Amet", userProfilePicturePublicId: nil, publicId: nil),
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "consectetur", userProfilePicturePublicId: nil, publicId: nil),
        StoryItemUIModel(relativeDate: "1 Hour Ago", userNameAndSurname: "adipiscing", userProfilePicturePublicId: nil, publicId: nil)
    ]
    
    static func getStoryImages() -> [DiscoverImageModel] {
        let image1 = DiscoverImageModel()
        image1.memberId = 1
        image1.publicId = nil
        image1.userName = "Lorem"
        image1.userNameAndSurname = "Lorem"
        image1.userProfilePicturePublicId = nil
        image1.createDate = Date().date(byAddingMinutes: -20)
        
        let image2 = DiscoverImageModel()
        image2.memberId = 2
        image2.publicId = nil
        image2.userName = "Ipsum"
        image2.userNameAndSurname = "Ipsum"
        image2.userProfilePicturePublicId = nil
        image2.createDate = Date().date(byAddingMinutes: -40)
        
        let image3 = DiscoverImageModel()
        image3.memberId = 3
        image3.publicId = nil
        image3.userName = "Dolor"
        image3.userNameAndSurname = "Dolor"
        image3.userProfilePicturePublicId = nil
        image3.createDate = Date().date(byAddingMinutes: -60)
        
        let image4 = DiscoverImageModel()
        image4.memberId = 4
        image4.publicId = nil
        image4.userName = "Sit"
        image4.userNameAndSurname = "Sit"
        image4.userProfilePicturePublicId = nil
        image4.createDate = Date().date(byAddingMinutes: -80)
        
        let image5 = DiscoverImageModel()
        image5.memberId = 5
        image5.publicId = nil
        image5.userName = "Amet"
        image5.userNameAndSurname = "Amet"
        image5.userProfilePicturePublicId = nil
        image5.createDate = Date().date(byAddingMinutes: -100)
        
        let image6 = DiscoverImageModel()
        image6.memberId = 6
        image6.publicId = nil
        image6.userName = "consectetur"
        image6.userNameAndSurname = "consectetur"
        image6.userProfilePicturePublicId = nil
        image6.createDate = Date().date(byAddingMinutes: -120)
        
        let image7 = DiscoverImageModel()
        image7.memberId = 7
        image7.publicId = nil
        image7.userName = "adipiscing"
        image7.userNameAndSurname = "adipiscing"
        image7.userProfilePicturePublicId = nil
        image7.createDate = Date().date(byAddingMinutes: -140)
        
        return [
            image1,
            image2,
            image3,
            image4,
            image5,
            image6,
            image7
        ]
    }
    
    static func getStories() -> [DiscoverStoryModel] {
        let story1 = DiscoverStoryModel()
        story1.images = getStoryImages().shuffled()
        
        let story2 = DiscoverStoryModel()
        story2.images = getStoryImages().shuffled()
        
        let story3 = DiscoverStoryModel()
        story3.images = getStoryImages().shuffled()
        
        let story4 = DiscoverStoryModel()
        story4.images = getStoryImages().shuffled()
        
        let story5 = DiscoverStoryModel()
        story5.images = getStoryImages().shuffled()
        
        let story6 = DiscoverStoryModel()
        story6.images = getStoryImages().shuffled()
        
        let story7 = DiscoverStoryModel()
        story7.images = getStoryImages().shuffled()
        
        let story8 = DiscoverStoryModel()
        story8.images = getStoryImages().shuffled()
        
        let story9 = DiscoverStoryModel()
        story9.images = getStoryImages().shuffled()
        
        return [
            story1,
            story2,
            story3,
            story4,
            story5,
            story6,
            story7,
            story7,
            story8,
            story9
        ]
    }
}
#endif
