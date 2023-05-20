//
//  IORefreshableScrollViewPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.05.2023.
//

import Foundation

#if DEBUG
struct IORefreshableScrollViewPreviewData {
    
    // MARK: - Defs
    
    struct Item: Identifiable {
        
        let id = UUID()
        let value: String
        
        init(value: String) {
            self.value = value
        }
    }
    
    // MARK: - Data
    
    static var previewData = [
        Item(value: "pwGallery0"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5"),
        Item(value: "pwGallery0"),
        Item(value: "pwGallery1"),
        Item(value: "pwGallery2"),
        Item(value: "pwGallery3"),
        Item(value: "pwGallery4"),
        Item(value: "pwGallery5")
    ]
}
#endif
