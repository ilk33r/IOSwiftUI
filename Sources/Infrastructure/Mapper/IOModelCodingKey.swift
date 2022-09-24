//
//  IOModelCodingKey.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

internal struct IOModelCodingKey: CodingKey {
    
    internal var stringValue: String
    internal var intValue: Int?

    internal init(_ string: String) {
        stringValue = string
    }

    internal init?(stringValue: String) {
        self.stringValue = stringValue
    }

    internal init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}
