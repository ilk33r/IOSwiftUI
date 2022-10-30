//
//  ImageAssetRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct ImageAssetRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "publicId")
    public var publicId: String?
    
    public init() {
    }
    
    public init(publicId: String?) {
        self.publicId = publicId
    }
}
