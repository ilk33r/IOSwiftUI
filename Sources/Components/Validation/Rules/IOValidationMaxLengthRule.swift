//
//  IOValidationMaxLengthRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation

public struct IOValidationMaxLengthRule: IOValidationRule {

    public var errorMessage: String
    
    private var length: Int
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
        self.length = 0
    }
    
    public init(errorMessage: String, length: Int) {
        self.errorMessage = errorMessage
        self.length = length
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        
        return value.count <= self.length
    }
}
