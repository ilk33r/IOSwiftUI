//
//  IOValidationAlphaNumericRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOValidationAlphaNumericRule: IOValidationRule {

    public var id: String { "IOValidationAlphaNumericRule" }
    public var errorMessage: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        let alphaSet = CharacterSet.alphanumerics
        return value.trimmingCharacters(in: alphaSet) == ""
    }
}
