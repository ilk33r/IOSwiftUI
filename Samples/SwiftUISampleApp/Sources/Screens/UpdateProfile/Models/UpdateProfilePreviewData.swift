//
//  UpdateProfilePreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.05.2023.
//

import Foundation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

#if DEBUG
struct UpdateProfilePreviewData {
    
    // MARK: - Data
    
    static func previewData() -> UpdateProfileEntity {
        let member = MemberModel()
        member.id = 1
        member.userName = "ilker0"
        member.birthDate = Date()
        member.email = "ilker0@ilker.com"
        member.name = "İlker"
        member.surname = "ÖZCAN"
        member.locationName = "Beşiktaş"
        member.isFollowing = true
        
        return UpdateProfileEntity(
            member: member
        )
    }
}
#endif
