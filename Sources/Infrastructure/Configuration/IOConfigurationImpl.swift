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
    
    public var defaultLocale: IOLocales { _defaultLocale }
    public var environment: IOEnvironmentType { _environment }
    
    // MARK: - Privates
    
    private let configValues: [String: Any]
    private var _defaultLocale: IOLocales!
    private var _environment: IOEnvironmentType!
    
    // MARK: - Initialization Methods
    
    public init() {
        // swiftlint:disable force_cast
        let buildConfigClass = NSClassFromString("IOBuildConfig") as! NSObject.Type
        self.configValues = buildConfigClass.value(forKey: "configValues") as! [String: Any]
        // swiftlint:enable force_cast
        
        self._defaultLocale = IOLocales(rawValue: self.configForType(type: .localizationDefaultLocaleIdentifier))
        self._environment = IOEnvironmentType(rawValue: self.configForType(type: .environment))
    }
    
    // MARK: - Getters
    
    public func configForType(type: IOConfigurationType) -> String {
        let configValue = configValues[type.rawValue] as? String
        return configValue ?? ""
    }
}
