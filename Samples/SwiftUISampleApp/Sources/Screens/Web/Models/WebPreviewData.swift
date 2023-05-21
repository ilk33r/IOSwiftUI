//
//  WebPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.05.2023.
//

import Foundation
import SwiftUISampleAppScreensShared

#if DEBUG
struct WebPreviewData {
    
    // MARK: - Data
    
    static var previewData = WebEntity(
        pageName: "PrivacyPolicy",
        pageTitle: .init(rawValue: "Privacy Policy"),
        titleIcon: "doc.text"
    )
}
#endif
