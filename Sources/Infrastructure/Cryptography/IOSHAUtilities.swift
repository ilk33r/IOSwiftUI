//
//  IOSHAUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import CommonCrypto
import Foundation

public struct IOSHAUtilities {
    
    public static func sha1(data: Data) -> Data? {
        // Create output data
        let outputData = NSMutableData(length: Int(CC_SHA1_DIGEST_LENGTH))!
        let inputData = data as NSData
        CC_SHA1(inputData.bytes, CC_LONG(inputData.length), outputData.mutableBytes)
        
        return outputData.copy() as? Data
    }
}
