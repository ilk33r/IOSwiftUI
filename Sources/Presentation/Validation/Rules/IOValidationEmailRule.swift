//
//  IOValidationEmailRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOValidationEmailRule: IOValidationRule {

    public var id: String { "IOValidationEmailRule" }
    public var errorMessage: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        let laxString = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", laxString)
        return emailPredicate.evaluate(with: value)
    }
}
