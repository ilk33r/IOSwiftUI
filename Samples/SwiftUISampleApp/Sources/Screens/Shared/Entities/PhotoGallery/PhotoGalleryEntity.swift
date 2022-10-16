// 
//  PhotoGalleryEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

public struct PhotoGalleryEntity: IOEntity {
    
    public let imagePublicIds: [String]
    public let isPresented: Binding<Bool>
    public let selectedIndex: Int
        
    public init(imagePublicIds: [String], isPresented: Binding<Bool>, selectedIndex: Int) {
        self.imagePublicIds = imagePublicIds
        self.isPresented = isPresented
        self.selectedIndex = selectedIndex
    }
}
