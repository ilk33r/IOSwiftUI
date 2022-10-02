//
//  ImageDataExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import SwiftUI

public extension Image {
    
    init(fromData imageData: Data) {
        let uiImage = UIImage(data: imageData) ?? UIImage()
        self.init(uiImage: uiImage)
    }
}
