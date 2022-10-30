//
//  MemberImagesResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberImagesResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "images")
    public var images: [MemberImageModel]?
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
