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
    public let type: GalleryCellView.`Type`
    
    public init(image: Image, type: GalleryCellView.`Type`) {
        self.image = image
        self.type = type
    }
}
