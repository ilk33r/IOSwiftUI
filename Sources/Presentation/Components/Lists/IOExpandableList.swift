// 
//  IOExpandableList.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.02.2023.
//

import Foundation
import SwiftUI

public struct IOExpandableList<Data, HeaderContent, RowContent>: View
where Data: RandomAccessCollection, Data.Element: IOExpandableListElement, HeaderContent: View, RowContent: View {
    
    // MARK: - Privates
    
    private let rowData: Data
    private let children: KeyPath<Data.Element, Data?>
    private let headerContent: (Data.Element) -> HeaderContent
    private let rowContent: (Data.Element) -> RowContent
    private let sectionPaddingLeft: CGFloat
    private let contentPaddingLeft: CGFloat
    
    // MARK: - Body
    
    public var body: some View {
        List(rowData, children: children) { it in
            if it.isSection {
                generateHeader(data: it)
                    .padding([.leading], sectionPaddingLeft)
                    .listRowInsets(EdgeInsets())
                    .background(Color.clear)
                    .listRowBackground(Color.clear)
            } else {
                generateRow(data: it)
                    .padding([.leading], contentPaddingLeft)
                    .listRowInsets(EdgeInsets())
                    .background(Color.clear)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ data: Data,
        children: KeyPath<Data.Element, Data?>,
        sectionPaddingLeft: CGFloat = -16,
        contentPaddingLeft: CGFloat = -32,
        @ViewBuilder headerContent: @escaping (Data.Element) -> HeaderContent,
        @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
    ) {
        self.rowData = data
        self.children = children
        self.headerContent = headerContent
        self.rowContent = rowContent
        self.sectionPaddingLeft = sectionPaddingLeft
        self.contentPaddingLeft = contentPaddingLeft
    }
    
    // MARK: - Helper Methods
    
    private func generateHeader(data: Data.Element) -> some View {
        if #available(iOS 15.0, *) {
            return headerContent(data)
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
        } else {
            return headerContent(data)
        }
    }
    
    private func generateRow(data: Data.Element) -> some View {
        if #available(iOS 15.0, *) {
            return rowContent(data)
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
        } else {
            return rowContent(data)
        }
    }
}

#if DEBUG
struct IOExpandableList_Previews: PreviewProvider {
    
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
    
    struct IOExpandableListDemo: View {
        
        let data: [ListData]
        
        var body: some View {
            IOExpandableList(
                data,
                children: \.childItems
            ) { it in
                Text(it.name)
                    .font(.system(size: 16, weight: .bold))
            } rowContent: { it in
                Text(it.name)
                    .font(.system(size: 14, weight: .regular))
            }
        }
        
        init() {
            self.data = [
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
    }
    
    static var previews: some View {
        prepare()
        return IOExpandableListDemo()
    }
}
#endif
