//
//  ProfileRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum ProfileRouters: IORouterDefinition {
    
    case settings(entity: SettingsEntity?)
    case updateProfile(entity: UpdateProfileEntity?)
    case userLocation(entity: UserLocationEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .settings(entity: let entity):
            return entity
            
        case .updateProfile(entity: let entity):
            return entity
            
        case .userLocation(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .settings:
            return "SettingsView"
            
        case .updateProfile:
            return "UpdateProfileView"
            
        case .userLocation:
            return "UserLocationView"
        }
    }
}
