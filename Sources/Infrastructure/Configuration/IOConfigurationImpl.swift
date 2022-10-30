//
//  IOConfigurationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOConfigurationImpl: IOConfiguration, IOSingleton {
    
    public typealias InstanceType = IOConfigurationImpl
    public static var _sharedInstance: IOConfigurationImpl!
    
    // MARK: - Publics
    
    public var defaultLocale: IOLocales { self._defaultLocale }
    public var environment: IOEnvironmentType { self._environment }
    
    // MARK: - Privates
    
    private let configValues: [String: Any]
    private var _defaultLocale: IOLocales!
    private var _environment: IOEnvironmentType!
    
    // MARK: - Initialization Methods
    
    public init() {
        let buildConfigClass = NSClassFromString("IOBuildConfig") as! NSObject.Type
        self.configValues = buildConfigClass.value(forKey: "configValues") as! [String: Any]
        
        self._defaultLocale = IOLocales(rawValue: self.configForType(type: .localizationDefaultLocaleIdentifier))
        self._environment = IOEnvironmentType(rawValue: self.configForType(type: .environment))
    }
    
    // MARK: - Getters
    
    public func configForType(type: IOConfigurationType) -> String {
        let configValue = self.configValues[type.rawValue] as? String
        return configValue ?? ""
    }
}
