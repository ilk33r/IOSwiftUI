//
//  IOValidatable.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation

public protocol IOValidatable: Identifiable<String> {
    
    var validationText: String? { get }
    
    func observedObject() -> IOValidatorObservedObject
}
