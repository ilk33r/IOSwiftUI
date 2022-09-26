//
//  DataExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation

public extension Data {
    
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    init(fromHexString hexString: String) {
        // Create byte length
        let byteLength = hexString.count / 2
        self.init(capacity: byteLength)
        
        var startIndex = hexString.startIndex
        for _ in 0..<byteLength {
            let endIndex = hexString.index(startIndex, offsetBy: 2)
            let bytes = hexString[startIndex..<endIndex]
            
            if var num = UInt8(bytes, radix: 16) {
                self.append(&num, count: 1)
            }
            
            startIndex = endIndex
        }
    }
    
    init(secureRandomizedData length: Int) {
        // Create bytes
        self.init(count: length)
        
        // Generate random bytes
        _ = self.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!)
        }
    }
}
