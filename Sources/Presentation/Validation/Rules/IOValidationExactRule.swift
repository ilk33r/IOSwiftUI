//
//  IOValidationExactRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOValidationExactRule: IOValidationRule {

    public var id: String { "IOValidationExactRule" }
    public var errorMessage: String
    
    private var compare: Binding<String>
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self.errorMessage = errorMessage.localized
        self.compare = Binding.constant("")
    }
    
    public init(errorMessage: IOLocalizationType, compare: Binding<String>) {
        self.errorMessage = errorMessage.localized
        self.compare = compare
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        guard let value else { return false }
        return value == compare.wrappedValue
    }
}
