//
//  GalleryCellData.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

public struct GalleryCellData: Identifiable {
    
    public let id = UUID()
    public let image: Image
    public let index: Int
    public let type: GalleryCellView.`Type`
    
    public init(
        image: Image,
        index: Int,
        type: GalleryCellView.`Type`
    ) {
        self.image = image
        self.index = index
        self.type = type
    }
}
