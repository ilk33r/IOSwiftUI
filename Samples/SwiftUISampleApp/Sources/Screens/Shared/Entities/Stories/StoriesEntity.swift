// 
//  StoriesEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon

public struct StoriesEntity: IOEntity {
    
    public let allStories: [DiscoverStoryModel]?
    public var isPresented: Binding<Bool>
    
    public init(
        allStories: [DiscoverStoryModel]?,
        isPresented: Binding<Bool>
    ) {
        self.allStories = allStories
        self.isPresented = isPresented
    }
}
