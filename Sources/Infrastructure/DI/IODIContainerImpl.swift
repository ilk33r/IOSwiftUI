//
//  IODIContainerImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation

final public class IODIContainerImpl: IODIContainer, IOSingleton {
    
    // MARK: - Singleton
    
    public typealias InstanceType = IODIContainerImpl
    public static var _sharedInstance: IODIContainerImpl!
    
    // MARK: - Privates
    
    private var instances: [String: any IOObject.Type]
    private var singletons: [String: any IOSingleton.Type]
    
    // MARK: - Initialization Methods
    
    public init() {
        self.instances = [:]
        self.singletons = [:]
    }
    
    // MARK: - Registers
    
    public func register(singleton type: Any, impl: any IOSingleton.Type) {
        let protocolName = String(describing: type)
        self.singletons[protocolName] = impl
    }
    
    public func register(class aClass: Any, impl: IOObject.Type) {
        let className = String(describing: aClass)
        self.instances[className] = impl
    }
    
    // MARK: - Resolvers
    
    public func resolve<TType>(_ type: TType.Type) -> TType! {
        if let resolvedObject = self.resolveOptional(type) {
            return resolvedObject
        }
        
        let typeName = String(describing: type)
        fatalError("\(typeName) could not found in container.")
    }
    
    public func resolveOptional<TType>(_ type: TType.Type) -> TType? {
        let typeName = String(describing: type)
        if let singleton = self.singletons[typeName]?.shared as? TType {
            return singleton
        }
        
        if
            let instanceType = self.instances[typeName],
            let instance = instanceType.init() as? TType
        {
            return instance
        }
        
        return nil
    }
}
