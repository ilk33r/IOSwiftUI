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
        Item(value: "Gallery0"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5"),
        Item(value: "Gallery0"),
        Item(value: "Gallery1"),
        Item(value: "Gallery2"),
        Item(value: "Gallery3"),
        Item(value: "Gallery4"),
        Item(value: "Gallery5")
    ]
}
#endif
