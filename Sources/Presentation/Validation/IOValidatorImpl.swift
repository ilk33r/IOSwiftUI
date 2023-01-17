//
//  IOValidatorImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

open class IOValidatorImpl: IOValidator {
    
    // MARK: - Definitions
    
    private struct ValidationObject {
        let rule: any IOValidationRule
        let validatable: any IOValidatable
    }
    
    // MARK: - Privates
    
    private var registeredRules: [ValidationObject]
    
    // MARK: - Initialization Methods
    
    public init() {
        self.registeredRules = []
    }
    
    // MARK: - Validation Methods
    
    open func register(rule: any IOValidationRule, validatable: any IOValidatable) {
        self.unregisterIfNecessary(rule: rule, validatable: validatable)
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
    
    open func validate() -> [any IOValidationRule] {
        var unvalidatedRules = [any IOValidationRule]()
        var unvalidatedValidatables = [any IOValidatable]()
        
        self.registeredRules.forEach { it in
            if unvalidatedValidatables.first(where: { $0.id == it.validatable.id }) != nil {
                return
            }
            
            if it.rule.validate(value: it.validatable.validationText) {
                it.validatable.observedObject().success()
            } else {
                it.validatable.observedObject().error(it.rule.errorMessage)
                unvalidatedRules.append(it.rule)
                unvalidatedValidatables.append(it.validatable)
            }
        }
        
        return unvalidatedRules
    }
    
    // MARK: - Helper Methods
    
    private func unregisterIfNecessary(rule: any IOValidationRule, validatable: any IOValidatable) {
        let ruleID = rule.id
        let ruleNameID = validatable.id
        
        self.registeredRules.removeAll(where: { $0.rule.id == ruleID && $0.validatable.id == ruleNameID })
    }
}
