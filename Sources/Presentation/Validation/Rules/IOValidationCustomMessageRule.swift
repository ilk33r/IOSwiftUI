//
//  IOValidationCustomMessageRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.01.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOValidationCustomMessageRule: IOValidationRule {

    public var id: String { "IOValidationCustomMessageRule" }
    public var errorMessage: String {
        get {
            return errorMessageBinder
        }
        set {
            _errorMessage = newValue
        }
    }

    // MARK: - Privates
    
    public var _errorMessage: String
    @Binding private var errorMessageBinder: String
    
    // MARK: - Initialization Methods
    
    public init(errorMessage: IOLocalizationType) {
        self._errorMessage = errorMessage.localized
        self._errorMessageBinder = Binding.constant("")
    }
    
    public init(errorMessageBinder: Binding<String>) {
        self._errorMessage = ""
        self._errorMessageBinder = errorMessageBinder
    }
    
    // MARK: - Validation Methods
    
    public func validate(value: String?) -> Bool {
        return errorMessage.isEmpty
    }
}
