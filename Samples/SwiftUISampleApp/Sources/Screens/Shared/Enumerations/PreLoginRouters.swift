//
//  PreLoginRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum PreLoginRouters: IORouterDefinition {
    
    case splash(entity: SplashEntity?)
    case login(entity: LoginEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .splash(entity: let entity):
            return entity
            
        case .login(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .splash:
            return "SplashView"
            
        case .login:
            return "LoginView"
        }
    }
}
