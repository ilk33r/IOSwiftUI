//
//  IOValidationRegexRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.01.2023.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOValidationRegexRule: IOValidationRule {

    public var id: String { "IOValidationRegexRule" }
    public var errorMessage: String
    
    private var regex: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
        self.regex = ""
    }
    
    public init(errorMessage: IOLocalizationType, regex: String) {
        self.errorMessage = errorMessage.localized
        self.regex = regex
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        if value == nil || value!.isEmpty {
            return true
        }
        
        if value?.range(of: self.regex, options: .regularExpression, range: nil, locale: nil) != nil {
            // Add regex error
            return true
        }
        
        return false
    }
}
