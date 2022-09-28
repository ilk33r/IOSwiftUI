//
//  IOValidator.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

open class IOValidator: IOObject {
    
    // MARK: - Definitions
    
    public struct ValidationObject {
        let rule: IOValidationRule
        let validatable: IOValidatable
    }
    
    // MARK: - Privates
    
    private var registeredRules: [ValidationObject]
    
    // MARK: - Initialization Methods
    
    required public init() {
        self.registeredRules = []
    }
    
    // MARK: - Validation Methods
    
    open func register(rule: IOValidationRule, validatable: IOValidatable) {
        self.registeredRules.append(ValidationObject(rule: rule, validatable: validatable))
    }
    
    open func unRegisterAll() {
        self.registeredRules = []
    }
    
    open func unvalidate() {
        self.registeredRules.forEach { it in
            it.validatable.observedObject().success()
        }
    }
    
    open func validate() -> [IOValidationRule] {
        var unvalidatedRules = [IOValidationRule]()
        
        self.registeredRules.forEach { it in
            if it.rule.validate(value: it.validatable.validationText) {
                it.validatable.observedObject().success()
            } else {
                it.validatable.observedObject().error(it.rule.errorMessage)
                unvalidatedRules.append(it.rule)
            }
        }
        
        return unvalidatedRules
    }
}
