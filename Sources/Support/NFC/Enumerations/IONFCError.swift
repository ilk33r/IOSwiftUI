//
//  IONFCError.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation

public enum IONFCError: Error {
    
    case readingNotAvailable
    case authenticationDataIsEmpty
    case userCancelled
    case tagValidation
    case tagConnection(message: String)
    case keyDerivation
    case connectionLost
    case tagRead
    case authentication
    case tagResponse
}
