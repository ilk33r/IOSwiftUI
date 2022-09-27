//
//  IOValidationRule.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.09.2022.
//

import Foundation

public protocol IOValidationRule {
    
    // MARK: - Messages
    
    var errorMessage: String { get set }
    
    // MARK: - Initialization Methods
    
    init(errorMessage: String)
    
    // MARK: - Validation Methods
    
    func validate(value: String?) -> Bool
}
