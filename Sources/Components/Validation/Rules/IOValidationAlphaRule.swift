//
//  IOValidationAlphaRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.09.2022.
//

import Foundation

public struct IOValidationAlphaRule: IOValidationRule {

    public var errorMessage: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        let alphaSet = CharacterSet.letters
        return value.trimmingCharacters(in: alphaSet) == ""
    }
}
