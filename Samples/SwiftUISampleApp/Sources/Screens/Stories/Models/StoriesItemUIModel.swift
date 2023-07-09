//
//  StoriesItemUIModel.swift
//
//
//  Created by Adnan ilker Ozcan on 9.07.2023.
//

import Foundation

struct StoriesItemUIModel: Identifiable {
    
    let images: [StoryItemUIModel]
    
    var id = UUID()
    
    init(
        images: [StoryItemUIModel]
    ) {
        self.images = images
    }
}
