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
    
    @Inject private var localization: IOLocalizationImpl
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
