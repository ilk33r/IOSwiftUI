//
//  ImageAssetResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation

public struct ImageAssetResponseModel: Codable {
    
    public let imageData: Data
    
    public init(data: Data) {
        self.imageData = data
    }
}
