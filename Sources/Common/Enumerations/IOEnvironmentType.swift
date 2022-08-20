//
//  IOEnvironmentType.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public struct IOEnvironmentType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let debug = IOEnvironmentType(rawValue: "Debug")
    public static let release = IOEnvironmentType(rawValue: "Release")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
