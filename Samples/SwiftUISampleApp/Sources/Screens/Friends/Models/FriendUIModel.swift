//
//  FriendUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import Foundation

struct FriendUIModel: Identifiable {
    
    var id = UUID()
    
    let userName: String
    let userNameAndSurname: String
    let locationName: String
    let locationLatitude: Double
    let locationLongitude: Double
    let profilePicturePublicId: String
    
    init(
        userName: String,
        userNameAndSurname: String,
        locationName: String,
        locationLatitude: Double,
        locationLongitude: Double,
        profilePicturePublicId: String
    ) {
        self.userName = userName
        self.userNameAndSurname = userNameAndSurname
        self.locationName = locationName
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.profilePicturePublicId = profilePicturePublicId
    }
}
