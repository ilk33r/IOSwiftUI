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
    
    public var localized: String { self.localization.string(self.rawValue) }
    
    @IOInject private var localization: IOLocalizationImpl
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func localized(alternateText: String) -> String {
        return self.localization.string(self.rawValue, alternateText: alternateText)
    }
    
    public func format( _ arguments: CVarArg...) -> IOLocalizationType {
        let rawValue = String(format: self.localized, arguments)
        return IOLocalizationType(rawValue: rawValue)
    }
}
