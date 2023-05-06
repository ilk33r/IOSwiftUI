//
//  TestConfigurationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct TestConfigurationImpl: IOConfiguration, IOSingleton {
    
    public typealias InstanceType = TestConfigurationImpl
    public static var _sharedInstance: TestConfigurationImpl!
    
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
