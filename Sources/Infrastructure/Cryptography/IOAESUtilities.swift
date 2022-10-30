//
//  IOAESUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import CommonCrypto
import Foundation

public struct IOAESUtilities {
 
    // MARK: - AES
    
    public static func encrypt(data: Data, keyData: Data, ivData: Data?) -> Data? {
        return self.crypt(data: data, algorithm: CCAlgorithm(kCCAlgorithmAES), operation: CCOperation(kCCEncrypt), key: keyData, iv: ivData)
    }
    
    public static func encrypt(string: String, keyData: Data, ivData: Data?) -> Data? {
        if let data = string.data(using: .utf8) {
            return self.encrypt(data: data, keyData: keyData, ivData: ivData)
        }
        
        return nil
    }
    
    public static func decrypt(data: Data, keyData: Data, ivData: Data?) -> Data? {
        return self.crypt(data: data, algorithm: CCAlgorithm(kCCAlgorithmAES), operation: CCOperation(kCCDecrypt), key: keyData, iv: ivData)
    }
    
    public static func decrypt(string: String, keyData: Data, ivData: Data?) -> Data? {
        if let data = string.data(using: .utf8) {
            return self.decrypt(data: data, keyData: keyData, ivData: ivData)
        }
        
        return nil
    }
    
    // MARK: - Helper Methods
    
    private static func crypt(data: Data, algorithm: CCAlgorithm, operation: CCOperation, key: Data, iv: Data?) -> Data? {
        // Convert key and iv to data
        let dataIn = NSMutableData(data: data)
        let keyData = NSMutableData(data: key)
        let ivData: NSMutableData
        
        // Create algorithm size
        var dataMoved = 0
        let algorithmSize = self.size(forAlgorithm: algorithm)
        
        // Create decrypted data
        let cryptedDataCapacity = data.count + algorithmSize
        let cryptedData = NSMutableData(length: cryptedDataCapacity)!
        
        // Create options
        var options = CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode)
        
        // Check iv is not null
        if let iv {
            // Then update options
            options = CCOptions(kCCOptionPKCS7Padding)
            ivData = NSMutableData(data: iv)
        } else {
            ivData = NSMutableData()
        }
        
        // Crypt data
        let status = CCCrypt(operation, algorithm, options, keyData.bytes, keyData.length, ivData.bytes, dataIn.bytes, dataIn.length, cryptedData.mutableBytes, cryptedDataCapacity, &dataMoved)

        // Check result
        if status == kCCSuccess {
            // Then update data size
            cryptedData.length = dataMoved
            return cryptedData as Data
        }
        
        return nil
    }
    
    private static func size(forAlgorithm algorithm: CCAlgorithm) -> Int {
        // Create size value
        var size = 0
        
        // Check algorithms
        if algorithm == kCCAlgorithmAES128 || algorithm == kCCAlgorithmAES {
            size = kCCBlockSizeAES128
        } else if algorithm == kCCAlgorithmDES {
            size = kCCBlockSizeDES
        } else if algorithm == kCCAlgorithm3DES {
            size = kCCBlockSize3DES
        } else if algorithm == kCCAlgorithmCAST {
            size = kCCBlockSizeCAST
        }
        
        return size
    }
}
