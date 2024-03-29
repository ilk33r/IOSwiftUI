//
//  IOHuggingPriorities.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation

public struct IOHuggingPriorities: OptionSet {
    
    public let rawValue: Int

    public static let horizontalLow = Self(rawValue: 1 << 0)
    public static let horizontalHigh = Self(rawValue: 1 << 1)
    public static let verticalLow = Self(rawValue: 1 << 2)
    public static let verticalHigh = Self(rawValue: 1 << 3)
    
    public static let resistanceHorizontalLow = Self(rawValue: 1 << 4)
    public static let resistanceHorizontalHigh = Self(rawValue: 1 << 5)
    public static let resistanceVerticalLow = Self(rawValue: 1 << 6)
    public static let resistanceVerticalHigh = Self(rawValue: 1 << 7)
    
    public static let allHorizontalLow: IOHuggingPriorities = [.horizontalLow, .resistanceHorizontalLow]
    public static let allHorizontalHigh: IOHuggingPriorities = [.horizontalHigh, .resistanceHorizontalHigh]
    public static let allVerticalLow: IOHuggingPriorities = [.verticalLow, .resistanceVerticalLow]
    public static let allVerticalHigh: IOHuggingPriorities = [.verticalHigh, .resistanceVerticalHigh]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
