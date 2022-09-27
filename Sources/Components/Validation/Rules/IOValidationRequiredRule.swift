//
//  IOValidationRequiredRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation

public struct IOValidationRequiredRule: IOValidationRule {

    public var errorMessage: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        
        return !value.isEmpty
    }
}
