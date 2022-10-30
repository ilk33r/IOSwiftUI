//
//  IORSAEncryptionUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import Security

public struct IORSAEncryptionUtilities {
    
    public enum PaddingType {
        case pkcs1
        case oaep
    }
    
    public static func encrypt(data: Data, publicKey: SecKey, rsaPaddingType: PaddingType = .pkcs1) -> Data? {
        // Convert data
        let plainData = data as CFData
        
        // Create an algorithm
        let algorithm: SecKeyAlgorithm
        
        // Check use pkcs1 padding
        if rsaPaddingType == .pkcs1 {
            algorithm = .rsaEncryptionPKCS1
        } else {
            algorithm = .rsaEncryptionOAEPSHA1
        }
        
        // swiftlint:disable redundant_optional_initialization
        var error: Unmanaged<CFError>? = nil
        let encryptedData = SecKeyCreateEncryptedData(publicKey, algorithm, plainData, &error)
        // swiftlint:enable redundant_optional_initialization
        
        return encryptedData as Data?
    }
}
