//
//  DiscoverStoryModel.swift
//
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation
import IOSwiftUICommon

public struct DiscoverStoryModel: BaseModel {
    
    @IOJsonProperty(key: "images")
    public var images: [DiscoverImageModel]?
    
    public init() {
    }
}
