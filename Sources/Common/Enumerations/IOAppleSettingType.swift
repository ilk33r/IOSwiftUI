//
//  IOAppleSettingType.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation

public struct IOAppleSettingType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let debugClearFileCache = Self(rawValue: "debug_clear_file_cache")
    public static let debugHTTPMenuToggle = Self(rawValue: "debug_http_menu_toggle")
    public static let debugRecordHTTPCalls = Self(rawValue: "debug_record_http_calls")
    public static let debugResetLocalStorage = Self(rawValue: "debug_reset_local_storage")
    public static let debugSimulateHTTPClient = Self(rawValue: "debug_simulate_http_client")
    public static let debugSimulationHTTPResponseTime = Self(rawValue: "debug_simulation_http_response_time")
    public static let debugAPIURL = Self(rawValue: "debug_api_url")
    public static let debugDefaultUserName = Self(rawValue: "debug_default_user_name")
    public static let debugDefaultPassword = Self(rawValue: "debug_default_password")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
