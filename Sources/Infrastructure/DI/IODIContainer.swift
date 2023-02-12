//
//  IODIContainer.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation

public protocol IODIContainer {
    
    // MARK: - Defs
    
    typealias InstanceBlock = () -> Any
    typealias SingletonBlock = () -> any IOSingleton.Type
    
    // MARK: - Controls
    
    func isRegistered<TType>(singleton type: TType.Type) -> Bool
    func isRegistered<TType>(class aClass: TType.Type) -> Bool
    
    // MARK: - Registers
    
    func register<TType>(singleton type: TType.Type, impl: @escaping SingletonBlock)
    func register<TType>(class aClass: TType.Type, impl: @escaping InstanceBlock)
    
    func unRegister<TType>(singleton type: TType.Type)
    func unRegister<TType>(class aClass: TType.Type)
    
    // MARK: - Resolvers
    
    func resolve<TType>(_ type: TType.Type) -> TType!
    func resolveOptional<TType>(_ type: TType.Type) -> TType?
    
    // MARK: - Clears
    
    func clearSingletons()
    
    // MARK: - Statics
    
    static func get<TType>(_ type: TType.Type) -> TType!
}

public extension IODIContainer {
 
    static func get<TType>(_ type: TType.Type) -> TType! {
        return IODIContainerImpl.shared.resolve(type)
    }
}
