//
//  RegisterRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum RegisterRouters: IORouterDefinition {
    
    case userName(entity: RegisterUserNameEntity?)
    case createPassword(entity: RegisterCreatePasswordEntity?)
    case mrzReader(entity: RegisterMRZReaderEntity?)
    case nfcReader(entity: RegisterNFCReaderViewEntity?)
    case profile(entity: RegisterProfileEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .userName(entity: let entity):
            return entity
            
        case .createPassword(entity: let entity):
            return entity
            
        case .mrzReader(entity: let entity):
            return entity
        
        case .nfcReader(entity: let entity):
            return entity
            
        case .profile(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .userName:
            return "RegisterUserNameView"
            
        case .createPassword:
            return "RegisterCreatePasswordView"
            
        case .mrzReader:
            return "RegisterMRZReaderView"
            
        case .nfcReader:
            return "RegisterNFCReaderViewView"
            
        case .profile:
            return "RegisterProfileView"
        }
    }
}
