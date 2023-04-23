//
//  IOTripleDESUtility.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import CommonCrypto
import Foundation

public struct IOTripleDESUtility {
    
    // MARK: - 3DES
    
    public static func encrypt(key: Data, iv: Data, message: Data) -> Data? {
        self.crypt(operation: CCOperation(kCCEncrypt), key: key, iv: iv, message: message)
    }
    
    public static func decrypt(key: Data, iv: Data, message: Data) -> Data? {
        self.crypt(operation: CCOperation(kCCDecrypt), key: key, iv: iv, message: message)
    }
    
    // MARK: - Helper Methods
    
    private static func crypt(operation: CCOperation, key: Data, iv: Data, message: Data) -> Data? {
        // Convert key and iv to data
        let dataIn = NSMutableData(data: message)
        let keyData = NSMutableData(data: key)
        let ivData = NSMutableData(data: iv)
        
        // Create crypted data
        var dataMoved = 0
        let cryptedDataCapacity = message.count + kCCBlockSize3DES
        let cryptedData = NSMutableData(length: cryptedDataCapacity)!
        
        // Crypt data
        let status = CCCrypt(
            operation,
            CCAlgorithm(kCCAlgorithm3DES),
            0,
            keyData.bytes,
            keyData.length,
            ivData.bytes,
            dataIn.bytes,
            dataIn.length,
            cryptedData.mutableBytes,
            cryptedDataCapacity,
            &dataMoved
        )
        
        // Check result
        if status == kCCSuccess {
            // Then update data size
            cryptedData.length = dataMoved
            return cryptedData as Data
        }
        
        return nil
    }
}
