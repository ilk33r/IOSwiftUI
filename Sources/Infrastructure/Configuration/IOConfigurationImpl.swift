//
//  IOConfigurationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOConfigurationImpl: IOConfiguration, IOSingleton {
    
    public typealias InstanceType = IOConfigurationImpl
    public static var _sharedInstance: IOConfigurationImpl!
    
    // MARK: - Publics
    
    public var environment: IOEnvironmentType { self._environment }
    
    // MARK: - Privates
    
    private var configurations: IOConfigurationObject?
    private var _environment: IOEnvironmentType
    
    // MARK: - Initialization Methods
    
    public init() {
        self._environment = IOEnvironmentType(rawValue: IOConfigurationType.environmentName.rawValue)
    }
    
    // MARK: - Setters
    
    public func setConfiguration(configurations: IOConfigurationObject) {
        self.configurations = configurations
    }
    
    public func setEnvironment(type: IOEnvironmentType) {
        self._environment = type
    }
    
    // MARK: - Getters
    
    public func configForType(type: IOConfigurationType) -> String {
        let environmentConfig = self.configurations?.configData[self._environment]
        let configValue = environmentConfig?[type]
        return configValue ?? ""
    }
}
