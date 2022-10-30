//
//  DiscoverImagesResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct DiscoverImagesResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "images")
    public var images: [DiscoverImageModel]?
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
