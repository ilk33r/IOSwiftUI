//
//  IOValidationMaxLengthRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOValidationMaxLengthRule: IOValidationRule {

    public var id: String { "IOValidationMaxLengthRule" }
    public var errorMessage: String
    
    private var length: Int
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
        self.length = 0
    }
    
    public init(errorMessage: IOLocalizationType, length: Int) {
        self.errorMessage = errorMessage.localized
        self.length = length
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        
        return value.count <= length
    }
}
