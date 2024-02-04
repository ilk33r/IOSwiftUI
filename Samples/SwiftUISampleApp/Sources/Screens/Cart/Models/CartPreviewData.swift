// 
//  CartPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import Foundation

#if DEBUG
struct CartPreviewData {
    
    // MARK: - Data
    
    static var previewData = ""
    static var previewDataItem = CartUIModel(
        picturePublicId: "pwGallery0",
        nameSurname: "İlker ÖZCAN",
        userName: "ilk33r",
        price: "$ 9.99"
    )
}
#endif
