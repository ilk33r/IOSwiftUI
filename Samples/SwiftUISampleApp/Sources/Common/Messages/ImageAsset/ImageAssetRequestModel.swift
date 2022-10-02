//
//  ImageAssetRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class ImageAssetRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "publicId")
    public var publicId: String?
    
    public init(publicId: String?) {
        super.init()
        self.publicId = publicId
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
