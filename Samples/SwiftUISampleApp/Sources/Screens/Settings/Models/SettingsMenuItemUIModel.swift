//
//  SettingsMenuItemUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

struct SettingsMenuItemUIModel: Identifiable {
    
    enum `Type` {
        case updateProfile
        case updateProfilePicture
        case removeProfilePicture
        case changePassword
        case privacyPolicy
        case termsAndConditions
        case logout
    }
    
    var iconName: String
    var localizableKey: IOLocalizationType
    var type: `Type`
    var id = UUID()
    
    init(iconName: String, localizableKey: IOLocalizationType, type: `Type`) {
        self.iconName = iconName
        self.localizableKey = localizableKey
        self.type = type
    }
}
