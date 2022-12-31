//
//  IOTestConfigurationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct IOTestConfigurationImpl: IOConfiguration, IOSingleton {
    
    public typealias InstanceType = IOTestConfigurationImpl
    public static var _sharedInstance: IOTestConfigurationImpl!
    
    // MARK: - Publics
    
    public var defaultLocale: IOLocales { .en }
    public var environment: IOEnvironmentType { .development }
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Getters
    
    public func configForType(type: IOConfigurationType) -> String {
        if type == .loggingLogLevel {
            return "verbose"
        }
        return ""
    }
}
