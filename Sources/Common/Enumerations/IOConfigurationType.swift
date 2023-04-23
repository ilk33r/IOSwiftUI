//
//  IOConfigurationType.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public struct IOConfigurationType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let environment = Self(rawValue: "GENERAL_ENVIRONMENT")
    public static let fileCacheDirectoryName = Self(rawValue: "GENERAL_FILE_CACHE_DIRECTORY_NAME")
    public static let localizationDefaultLocaleIdentifier = Self(rawValue: "LOCALIZATION_DEFAULT_LOCALE_IDENTIFIER")
    public static let localStoragePrefix = Self(rawValue: "LOCAL_STORAGE_PREFIX")
    public static let loggingLogLevel = Self(rawValue: "LOGGING_LOG_LEVEL")
    public static let networkingApiTimeout = Self(rawValue: "NETWORKING_API_TIMEOUT")
    public static let networkingApiUrl = Self(rawValue: "NETWORKING_API_URL")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
