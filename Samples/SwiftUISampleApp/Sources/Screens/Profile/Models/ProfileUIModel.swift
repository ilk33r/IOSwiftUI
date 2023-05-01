//
//  ProfileUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 14.10.2022.
//

import Foundation

struct ProfileUIModel: Equatable {
    
    let name: String
    let nameSurname: String
    let locationName: String
    let isOwnProfile: Bool
    let isFollowing: Bool
    let profilePicturePublicId: String?
    
    // MARK: - Equatable
    
    static func == (lhs: ProfileUIModel, rhs: ProfileUIModel) -> Bool {
        lhs.profilePicturePublicId == rhs.profilePicturePublicId && lhs.name == rhs.name && lhs.nameSurname == rhs.nameSurname
    }
}
