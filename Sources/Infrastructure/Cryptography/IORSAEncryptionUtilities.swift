//
//  IORSAEncryptionUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import Security

final public class IORSAEncryptionUtilities {
    
    public enum PaddingType {
        case pkcs1
        case oaep
    }
    
    public static func encrypt(data: Data, publicKey: SecKey, rsaPaddingType: PaddingType = .pkcs1) -> Data? {
        // Plain text bytes
        let plainText = data.bytes
        let plainTextLen = data.count
        
        // Create cipher text and block size
        let blockSize = SecKeyGetBlockSize(publicKey) * MemoryLayout<UInt8>.size
        var cipherText: [UInt8] = Array(repeating: 0, count: blockSize)
        
        var blockSizePerEncrypt = 0
        var paddingType = SecPadding(rawValue: 0)
        
        // Check use pkcs1 padding
        if rsaPaddingType == .pkcs1 {
            // When PKCS1 padding is performed, the maximum length of data that can
            // be encrypted is the value returned by SecKeyGetBlockSize() - 11.
            blockSizePerEncrypt = blockSize - 11
            paddingType = .PKCS1
        } else if rsaPaddingType == .oaep {
            // When OAEP padding is performed, the maximum length of data that can
            // be encrypted is the value returned by SecKeyGetBlockSize() - 2 - (2 * hash size).
            blockSizePerEncrypt = blockSize - 2 - (2 * 20)
            paddingType = .OAEP
        }
        
        // Create encrypted data
        var accumulatedEncryptedData = Data()
        
        // Create block sizes
        var needEncryptLen = 0
        var realEncryptLen = 0
        
        // Loop throught ciphers
        for i in stride(from: 0, to: plainTextLen, by: blockSizePerEncrypt) {
            // Calculate block sizes
            needEncryptLen = plainTextLen - i
            realEncryptLen = blockSize
            
            // Check needed encrypt length is greater than block size
            if needEncryptLen > blockSizePerEncrypt {
                needEncryptLen = blockSizePerEncrypt
            }
            
            // Encrypt text
            var plainTextStripped = plainText.dropFirst(i)
            let status = SecKeyEncrypt(publicKey, paddingType, &plainTextStripped, needEncryptLen, &cipherText[i], &realEncryptLen)
            
            // Check status is success
            if status == errSecSuccess {
                // Append encrypted bytes
                accumulatedEncryptedData.append(&cipherText, count: realEncryptLen)
            } else {
                // Break the loop
                break
            }
            
            // Update values
            realEncryptLen = 0
            cipherText = Array(repeating: 0, count: blockSize)
        }
        
        return accumulatedEncryptedData
    }
}
