//
//  IOBiometricAuthenticatorError.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.12.2022.
//

import Foundation

public enum IOBiometricAuthenticatorError: Error {
    
    case dataSign
    case keyCreation
    case keyNotFound
    case userCancelled
    case doesNotSupport(message: String)
    case locked
    case unlockError(message: String)
    case authFailed
}
