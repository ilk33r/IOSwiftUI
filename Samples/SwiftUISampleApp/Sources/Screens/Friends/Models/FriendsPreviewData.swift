//
//  FriendsPreviewData.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.05.2023.
//

import Foundation
import SwiftUISampleAppCommon

#if DEBUG
struct FriendsPreviewData {
    
    // MARK: - Data
    
    static var previewData = ""
    
    static var previewDataItem = FriendUIModel(
        userName: "ilker0",
        userNameAndSurname: "İlker ÖZCAN",
        locationName: "Avcılar, İstanbul",
        locationLatitude: 0,
        locationLongitude: 0,
        profilePicturePublicId: ""
    )
    
    static func previewDataView() -> MemberFriendsResponseModel {
        let friends = MemberFriendsResponseModel()
        friends.followers = [
            generateFriendData(index: 0),
            generateFriendData(index: 1),
            generateFriendData(index: 2),
            generateFriendData(index: 3),
            generateFriendData(index: 4),
            generateFriendData(index: 5),
            generateFriendData(index: 6),
            generateFriendData(index: 7),
            generateFriendData(index: 8),
            generateFriendData(index: 9)
        ]
        friends.followings = [
            generateFriendData(index: 10),
            generateFriendData(index: 11),
            generateFriendData(index: 12),
            generateFriendData(index: 13),
            generateFriendData(index: 14),
            generateFriendData(index: 15),
            generateFriendData(index: 16),
            generateFriendData(index: 17),
            generateFriendData(index: 18),
            generateFriendData(index: 19),
            generateFriendData(index: 20),
            generateFriendData(index: 21),
            generateFriendData(index: 22),
            generateFriendData(index: 23),
            generateFriendData(index: 24),
            generateFriendData(index: 25),
            generateFriendData(index: 26),
            generateFriendData(index: 27),
            generateFriendData(index: 28),
            generateFriendData(index: 29)
        ]
        
        return friends
    }
    
    private static func generateFriendData(index: Int) -> MemberFriendModel {
        let friend = MemberFriendModel()
        friend.id = index
        friend.userName = "ilker\(index)"
        friend.userNameAndSurname = "\(index) İlker Özcan"
        friend.locationName = "\(index) İstanbul"
        friend.locationLatitude = 41.066110 + Double(index * 4)
        friend.locationLongitude = 28.716310 - Double(index * 4)
        return friend
    }
}
#endif
