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
    
    struct IOExpandableListDemo: View {
        
        let data: [IOExpandableListPreviewData.ListData]
        
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
            self.data = IOExpandableListPreviewData.previewData
        }
    }
    
    static var previews: some View {
        prepare()
        return IOExpandableListDemo()
    }
}
#endif
