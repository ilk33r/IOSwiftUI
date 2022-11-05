//
//  SettingsMenuItemUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

struct SettingsMenuItemUIModel: Identifiable {
    
    var iconName: String
    var localizableKey: IOLocalizationType
    var id = UUID()
    
    init(iconName: String, localizableKey: IOLocalizationType) {
        self.iconName = iconName
        self.localizableKey = localizableKey
    }
}
