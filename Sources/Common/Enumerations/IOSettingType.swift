//
//  IOSettingType.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation

public struct IOSettingType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    #if DEBUG
    public static let debugHTTPMenuToggle = IOSettingType(rawValue: "debug_http_menu_toggle")
    public static let debugRecordHTTPCalls = IOSettingType(rawValue: "debug_record_http_calls")
    public static let debugSimulateHTTPClients = IOSettingType(rawValue: "debug_simulate_http_clients")
    public static let debugSimulationHTTPResponseTime = IOSettingType(rawValue: "debug_simulation_http_response_time")
    public static let debugAPIURL = IOSettingType(rawValue: "debug_api_url")
    public static let debugDefaultUserName = IOSettingType(rawValue: "debug_default_user_name")
    public static let debugDefaultPassword = IOSettingType(rawValue: "debug_default_password")
    #endif
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
