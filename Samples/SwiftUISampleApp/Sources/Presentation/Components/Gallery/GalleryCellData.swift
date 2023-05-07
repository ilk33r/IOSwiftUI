//
//  GalleryCellData.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

public struct GalleryCellData: Identifiable {
    
    public let imagePublicId: String
    public let index: Int
    public let type: GalleryCellView.`Type`
    
    public var id = UUID().uuidString
    
    public init(
        imagePublicId: String,
        index: Int,
        type: GalleryCellView.`Type`
    ) {
        self.imagePublicId = imagePublicId
        self.index = index
        self.type = type
    }
}
