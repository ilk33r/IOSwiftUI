//
//  IOAppleSettingType.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation

public struct IOAppleSettingType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let debugHTTPMenuToggle = IOAppleSettingType(rawValue: "debug_http_menu_toggle")
    public static let debugRecordHTTPCalls = IOAppleSettingType(rawValue: "debug_record_http_calls")
    public static let debugSimulateHTTPClient = IOAppleSettingType(rawValue: "debug_simulate_http_client")
    public static let debugSimulationHTTPResponseTime = IOAppleSettingType(rawValue: "debug_simulation_http_response_time")
    public static let debugAPIURL = IOAppleSettingType(rawValue: "debug_api_url")
    public static let debugDefaultUserName = IOAppleSettingType(rawValue: "debug_default_user_name")
    public static let debugDefaultPassword = IOAppleSettingType(rawValue: "debug_default_password")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
