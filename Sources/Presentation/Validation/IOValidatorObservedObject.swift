//
//  IOValidatorObservedObject.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.09.2022.
//

import Foundation

final public class IOValidatorObservedObject: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var errorMessage = ""
    @Published public var isValidated = true
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Validation Methods
    
    public func success() {
        self.isValidated = true
    }
    
    public func error(_ message: String) {
        self.errorMessage = message
        self.isValidated = false
    }
}
