//
//  IOValidationRequiredRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOValidationRequiredRule: IOValidationRule {

    public var id: String { "IOValidationRequiredRule" }
    public var errorMessage: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        
        return !value.isEmpty
    }
}
