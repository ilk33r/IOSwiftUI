// 
//  PhotoGalleryEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct PhotoGalleryEntity: IOEntity {
    
    let images: [Image]
    
    init(images: [Image]) {
        self.images = images
    }
    
    init(from decoder: Decoder) throws {
        self.images = []
    }
    
    func encode(to encoder: Encoder) throws {
    }
}
