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
    
    let imagePublicIds: [String]
    let selectedIndex: Int
    
    init(
        imagePublicIds: [String],
        selectedIndex: Int
    ) {
        self.imagePublicIds = imagePublicIds
        self.selectedIndex = selectedIndex
    }
}
