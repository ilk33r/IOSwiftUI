//
//  IOStorageType.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

public struct IOStorageType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String

    public static let fontsRegistered = IOStorageType(rawValue: "fontsRegistered")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
