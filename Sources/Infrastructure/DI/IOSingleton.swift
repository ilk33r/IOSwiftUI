//
//  IOSingleton.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

public protocol IOSingleton {
    
    associatedtype InstanceType: IOSingleton
    
    static var shared: Self.InstanceType { get }
    static var _sharedInstance: Self.InstanceType! { get set }
    
    init()
}

public extension IOSingleton {
    
    static var shared: Self.InstanceType {
        if Self._sharedInstance == nil {
            Self._sharedInstance = Self.InstanceType()
        }
        
        return Self._sharedInstance
    }
    
    static func _cleanup() {
        Self._sharedInstance = nil
    }
}
