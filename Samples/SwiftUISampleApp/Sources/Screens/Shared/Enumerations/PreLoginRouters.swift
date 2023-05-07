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
    case loginPassword(entity: LoginPasswordEntity?)
    case register(entity: RegisterEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .splash(entity: let entity):
            return entity
            
        case .login(entity: let entity):
            return entity
            
        case .loginPassword(entity: let entity):
            return entity
            
        case .register(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .splash:
            return "SplashView"
            
        case .login:
            return "LoginView"
            
        case .loginPassword:
            return "LoginPasswordView"
            
        case .register:
            return "RegisterView"
        }
    }
}
