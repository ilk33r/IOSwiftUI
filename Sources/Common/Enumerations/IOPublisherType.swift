//
//  IOPublisherType.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.02.2023.
//

import Foundation

public struct IOPublisherType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
