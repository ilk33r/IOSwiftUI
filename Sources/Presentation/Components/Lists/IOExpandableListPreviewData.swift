//
//  IOExpandableListPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.05.2023.
//

import Foundation

#if DEBUG
struct IOExpandableListPreviewData {
    
    // MARK: - Defs
    
    struct ListData: IOExpandableListElement {
        
        let name: String
        let childItems: [ListData]?
        
        var id: Int
        var isSection: Bool
        
        init(
            name: String,
            id: Int,
            isSection: Bool,
            childItems: [ListData]?
        ) {
            self.name = name
            self.id = id
            self.isSection = isSection
            self.childItems = childItems
        }
    }
    
    // MARK: - Data
    
    static var previewData = [
        ListData(name: "Section 0", id: 0, isSection: true, childItems: [
            ListData(name: "Item 0", id: 1, isSection: false, childItems: nil),
            ListData(name: "Item 1", id: 2, isSection: false, childItems: nil),
            ListData(name: "Item 2", id: 3, isSection: false, childItems: nil),
            ListData(name: "Item 3", id: 4, isSection: false, childItems: nil),
            ListData(name: "Item 4", id: 5, isSection: false, childItems: nil),
            ListData(name: "Item 5", id: 6, isSection: false, childItems: nil),
            ListData(name: "Item 6", id: 7, isSection: false, childItems: nil)
        ]),
        ListData(name: "Section 1", id: 8, isSection: true, childItems: [
            ListData(name: "Item 0", id: 9, isSection: false, childItems: nil),
            ListData(name: "Item 1", id: 10, isSection: false, childItems: nil),
            ListData(name: "Item 2", id: 11, isSection: false, childItems: nil),
            ListData(name: "Item 3", id: 12, isSection: false, childItems: nil),
            ListData(name: "Item 4", id: 13, isSection: false, childItems: nil),
            ListData(name: "Item 5", id: 14, isSection: false, childItems: nil),
            ListData(name: "Item 6", id: 15, isSection: false, childItems: nil)
        ]),
        ListData(name: "Section 2", id: 16, isSection: true, childItems: [
            ListData(name: "Item 0", id: 17, isSection: false, childItems: nil),
            ListData(name: "Item 1", id: 18, isSection: false, childItems: nil),
            ListData(name: "Item 2", id: 19, isSection: false, childItems: nil),
            ListData(name: "Item 3", id: 20, isSection: false, childItems: nil),
            ListData(name: "Item 4", id: 21, isSection: false, childItems: nil),
            ListData(name: "Item 5", id: 22, isSection: false, childItems: nil),
            ListData(name: "Item 6", id: 23, isSection: false, childItems: nil)
        ]),
        ListData(name: "Section 3", id: 24, isSection: true, childItems: [
            ListData(name: "Item 0", id: 25, isSection: false, childItems: nil),
            ListData(name: "Item 1", id: 26, isSection: false, childItems: nil),
            ListData(name: "Item 2", id: 27, isSection: false, childItems: nil),
            ListData(name: "Item 3", id: 28, isSection: false, childItems: nil),
            ListData(name: "Item 4", id: 29, isSection: false, childItems: nil),
            ListData(name: "Item 5", id: 30, isSection: false, childItems: nil),
            ListData(name: "Item 6", id: 31, isSection: false, childItems: nil)
        ]),
        ListData(name: "Section 4", id: 32, isSection: true, childItems: [
            ListData(name: "Item 0", id: 33, isSection: false, childItems: nil),
            ListData(name: "Item 1", id: 34, isSection: false, childItems: nil),
            ListData(name: "Item 2", id: 35, isSection: false, childItems: nil),
            ListData(name: "Item 3", id: 36, isSection: false, childItems: nil),
            ListData(name: "Item 4", id: 37, isSection: false, childItems: nil),
            ListData(name: "Item 5", id: 38, isSection: false, childItems: nil),
            ListData(name: "Item 6", id: 39, isSection: false, childItems: nil)
        ]),
        ListData(name: "Section 5", id: 40, isSection: true, childItems: [
            ListData(name: "Item 0", id: 41, isSection: false, childItems: nil),
            ListData(name: "Item 1", id: 42, isSection: false, childItems: nil),
            ListData(name: "Item 2", id: 43, isSection: false, childItems: nil),
            ListData(name: "Item 3", id: 44, isSection: false, childItems: nil),
            ListData(name: "Item 4", id: 45, isSection: false, childItems: nil),
            ListData(name: "Item 5", id: 46, isSection: false, childItems: nil),
            ListData(name: "Item 6", id: 47, isSection: false, childItems: nil)
        ])
    ]
}
#endif
