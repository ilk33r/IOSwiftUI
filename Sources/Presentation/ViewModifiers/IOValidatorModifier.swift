//
//  IOValidatorModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation
import SwiftUI

public extension View where Self: IOValidatable {
    
    @ViewBuilder
    func registerValidator(
        to validator: IOValidator,
        rule: any IOValidationRule
    ) -> some View {
        modifier(IOValidatorModifier(to: validator, rule: rule, validatable: self))
    }
    
    @ViewBuilder
    func registerValidator(
        to validator: IOValidator,
        rules: [any IOValidationRule]
    ) -> some View {
        modifier(IOValidatorModifier(to: validator, rules: rules, validatable: self))
    }
}

struct IOValidatorModifier: ViewModifier {
    
    init(to validator: IOValidator, rule: any IOValidationRule, validatable: any IOValidatable) {
        validator.register(rule: rule, validatable: validatable)
    }
    
    init(to validator: IOValidator, rules: [any IOValidationRule], validatable: any IOValidatable) {
        rules.forEach { rule in
            validator.register(rule: rule, validatable: validatable)
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}
