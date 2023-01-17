//
//  IOValidationMinAmountRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOValidationMinAmountRule: IOValidationRule {

    public var id: String { "IOValidationMinAmountRule" }
    public var errorMessage: String
    
    private var amount: Int
    private var fractionLength: Int
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
        self.amount = 0
        self.fractionLength = 0
    }
    
    public init(errorMessage: IOLocalizationType, amount: Double, fractionLength: Int) {
        self.errorMessage = errorMessage.localized
        self.fractionLength = fractionLength
        self.amount = Int(amount * Double(10 * fractionLength))
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        
        guard let numberValue = formatter.number(from: value) else { return false }
        let intValue = Int(numberValue.doubleValue * Double(10 * fractionLength))
        
        if intValue >= amount {
            return true
        }
        
        return false
    }
}
