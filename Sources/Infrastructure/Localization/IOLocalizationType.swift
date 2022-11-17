//
//  IOLocalizationType.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

public struct IOLocalizationType: RawRepresentable, Equatable {
    
    public typealias RawValue = String
    
    public var rawValue: String
    
    public var localized: String { localization.string(rawValue) }
    
    @IOInject private var localization: IOLocalization
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func localized(alternateText: String) -> String {
        return localization.string(rawValue, alternateText: alternateText)
    }
    
    public func format( _ arguments: CVarArg...) -> IOLocalizationType {
        let rawValue = String(format: localized, arguments)
        return IOLocalizationType(rawValue: rawValue)
    }
}
