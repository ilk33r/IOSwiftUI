//
//  DiscoverStoriesResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation
import IOSwiftUICommon

public struct DiscoverStoriesResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "stories")
    public var stories: [DiscoverStoryModel]?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
