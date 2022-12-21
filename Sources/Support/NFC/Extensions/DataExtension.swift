//
//  DataExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

extension Data {
    
    static func nfcIV() -> Data {
        return Data(repeating: 0, count: 8)
    }
    
    func nfcAddPadding() -> Data {
        let size = 8
        let padBlock: [UInt8] = [ 0x80, 0, 0, 0, 0, 0, 0, 0 ]
        let left = size - (self.count % size)
        
        var leftedPadBlock = [UInt8]()
        
        for i in 0..<left {
            leftedPadBlock.append(padBlock[i])
        }
        
        let paddingData = Data(leftedPadBlock)
        return self + paddingData
    }
    
    func nfcMACKey(key: Data) -> Data {
        let size = self.count / 8
        let encryptionKey = key.subdata(in: 0..<8)
        let decryptionKey = key.subdata(in: 8..<16)
        
        var encryptedData = Data.nfcIV()
        
        for i in 0..<size {
            let start = i * 8
            let messageBuffer = self.subdata(in: start..<start + 8)
            encryptedData = IODESUtility.encrypt(key: encryptionKey, iv: encryptedData, message: messageBuffer, ecbMode: false)!
        }
        
        let invertMac = IODESUtility.decrypt(key: decryptionKey, iv: Data.nfcIV(), message: encryptedData, ecbMode: true)!
        return IODESUtility.encrypt(key: encryptionKey, iv: Data.nfcIV(), message: invertMac, ecbMode: true)!
    }
    
    func nfcRemovePadding() -> Data {
        var i = self.count - 1
        let bytes = self.bytes
        
        while bytes[i] == 0x00 {
            i -= 1
        }
        
        if bytes[i] == 0x80 {
            return self.subdata(in: 0..<i)
        }
        
        return self
    }
}
