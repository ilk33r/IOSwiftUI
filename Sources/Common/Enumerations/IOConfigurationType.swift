//
//  IOConfigurationType.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public struct IOConfigurationType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    #if ENV_PROD
    public static let environmentName = IOConfigurationType(rawValue: "Release")
    #else
    public static let environmentName = IOConfigurationType(rawValue: "Debug")
    #endif
    
    public static let apiURL = IOConfigurationType(rawValue: "apiURL")
    public static let apiTimeout = IOConfigurationType(rawValue: "apiTimeout")
    public static let localStoragePrefix = IOConfigurationType(rawValue: "localStoragePrefix")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
