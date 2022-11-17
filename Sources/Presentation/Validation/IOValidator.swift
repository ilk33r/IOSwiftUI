//
//  IOValidator.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public protocol IOValidator {
    
    // MARK: - Validation Methods
    
    func register(rule: IOValidationRule, validatable: any IOValidatable)
    func unRegisterAll()
    func unvalidate()
    func validate() -> [IOValidationRule]
}
