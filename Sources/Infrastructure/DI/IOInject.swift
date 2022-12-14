//
//  IOInject.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

@propertyWrapper final public class IOInject<Value> {
    
    public var wrappedValue: Value {
        if _resolvedObject == nil {
            _resolvedObject = container.resolve(Value.self)
        }
        
        return _resolvedObject
    }
    
    private var container: IODIContainer { IODIContainerImpl.shared }
    private var _resolvedObject: Value!
    
    public init() {
        _resolvedObject = container.resolveOptional(Value.self)
    }
}
