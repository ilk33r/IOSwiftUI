//
//  MemberImagesResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class MemberImagesResponseModel: BaseResponseModel {
    
    @IOJsonProperty(key: "images")
    public var images: [MemberImageModel]?
    
    @IOJsonProperty(key: "pagination")
    public var pagination: PaginationModel?
}
