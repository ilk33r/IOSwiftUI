//
//  IOBiometricAuthenticatorSignUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.12.2022.
//

import Foundation
import Security

struct IOBiometricAuthenticatorSignUtilities {
    
    static func sign(data: Data, privateKey: SecKey) -> Data? {
        // Convert data
        let plainData = data as CFData
        
        // Create an algorithm
        let algorithm: SecKeyAlgorithm = .ecdsaSignatureMessageX962SHA256
        
        // swiftlint:disable redundant_optional_initialization
        var error: Unmanaged<CFError>? = nil
        let encryptedData = SecKeyCreateSignature(privateKey, algorithm, plainData, &error)
        // swiftlint:enable redundant_optional_initialization
        
        return encryptedData as Data?
    }
}
