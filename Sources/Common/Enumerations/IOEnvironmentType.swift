//
//  IOEnvironmentType.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public struct IOEnvironmentType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let development = IOEnvironmentType(rawValue: "Development")
    public static let sit = IOEnvironmentType(rawValue: "SIT")
    public static let uat = IOEnvironmentType(rawValue: "UAT")
    public static let preProd = IOEnvironmentType(rawValue: "PreProd")
    public static let prod = IOEnvironmentType(rawValue: "Prod")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
