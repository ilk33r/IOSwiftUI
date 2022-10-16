//
//  HomeRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.10.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum HomeRouters: IORouterDefinition {
    
    case home(entity: HomeEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .home(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .home:
            return "HomeView"
        }
    }
}
