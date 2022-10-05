//
//  DiscoverImagesResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

final public class DiscoverImagesResponseModel: BaseResponseModel {
    
    @IOJsonProperty(key: "images")
    public var images: [DiscoverImageModel]?
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
}
