//
//  SearchPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.04.2023.
//

import Foundation

#if DEBUG
struct SearchPreviewData {
    
    static let previewData = [
        SearchUIModel(imagePublicId: "", userName: "User0", isDummy: true),
        SearchUIModel(imagePublicId: "", userName: "User1", isDummy: true),
        SearchUIModel(imagePublicId: "", userName: "User2", isDummy: true),
        SearchUIModel(imagePublicId: "", userName: "User3", isDummy: true),
        SearchUIModel(imagePublicId: "", userName: "User4", isDummy: true),
        SearchUIModel(imagePublicId: "", userName: "User5", isDummy: true)
    ]
    
    static let previewDataCell = SearchUIModel(
        imagePublicId: "",
        userName: "ilker",
        isDummy: false
    )
}
#endif
