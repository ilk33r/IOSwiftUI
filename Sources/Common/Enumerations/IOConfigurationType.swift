//
//  IOConfigurationType.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public struct IOConfigurationType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let environment = IOConfigurationType(rawValue: "GENERAL_ENVIRONMENT")
    public static let fileCacheDirectoryName = IOConfigurationType(rawValue: "GENERAL_FILE_CACHE_DIRECTORY_NAME")
    public static let localizationDefaultLocaleIdentifier = IOConfigurationType(rawValue: "LOCALIZATION_DEFAULT_LOCALE_IDENTIFIER")
    public static let localStoragePrefix = IOConfigurationType(rawValue: "LOCAL_STORAGE_PREFIX")
    public static let loggingLogLevel = IOConfigurationType(rawValue: "LOGGING_LOG_LEVEL")
    public static let networkingApiTimeout = IOConfigurationType(rawValue: "NETWORKING_API_TIMEOUT")
    public static let networkingApiUrl = IOConfigurationType(rawValue: "NETWORKING_API_URL")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
