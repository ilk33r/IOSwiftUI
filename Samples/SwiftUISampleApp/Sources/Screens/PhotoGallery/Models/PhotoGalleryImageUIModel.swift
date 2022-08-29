//
//  PhotoGalleryImageUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import SwiftUI

struct PhotoGalleryImageUIModel: Identifiable {
    
    let id = UUID()
    let image: Image
    
    init(image: Image) {
        self.image = image
    }
}
