//
//  IOLocales.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

public struct IOLocales: RawRepresentable, Equatable {
    
    public typealias RawValue = String
    
    public static let en = Self(rawValue: "en_US")
    public static let tr = Self(rawValue: "tr_TR")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
