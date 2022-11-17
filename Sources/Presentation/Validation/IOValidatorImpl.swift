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
        let rule: IOValidationRule
        let validatable: any IOValidatable
    }
    
    // MARK: - Privates
    
    private var registeredRules: [ValidationObject]
    
    // MARK: - Initialization Methods
    
    public init() {
        self.registeredRules = []
    }
    
    // MARK: - Validation Methods
    
    open func register(rule: IOValidationRule, validatable: any IOValidatable) {
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
}
