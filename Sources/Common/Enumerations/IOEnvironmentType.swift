//
//  IOEnvironmentType.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public struct IOEnvironmentType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let development = Self(rawValue: "Development")
    public static let sit = Self(rawValue: "SIT")
    public static let uat = Self(rawValue: "UAT")
    public static let preProd = Self(rawValue: "PreProd")
    public static let prod = Self(rawValue: "Prod")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
