//
//  IODIContainer.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation

public protocol IODIContainer {
    
    // MARK: - Registers
    
    func register(singleton type: Any, impl: any IOSingleton.Type)
    func register(class aClass: Any, impl: IOObject.Type)
    
    // MARK: - Resolvers
    
    func resolve<TType>(_ type: TType.Type) -> TType!
    func resolveOptional<TType>(_ type: TType.Type) -> TType?
}
