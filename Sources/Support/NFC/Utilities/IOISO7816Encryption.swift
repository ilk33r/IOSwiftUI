//
//  IOISO7816Encryption.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import CoreNFC
import Foundation
import IOSwiftUIInfrastructure

final class IOISO7816Encryption {
    
    // MARK: - Privates
    
    private let encryptionKey: Data
    private let mac: Data
    private var ssc: Data
    
    // MARK: - Initialization Methods
    
    init(encryptionKey: Data, mac: Data, ssc: Data) {
        if encryptionKey.count == 16 {
            self.encryptionKey = encryptionKey + encryptionKey.subdata(in: 0..<8)
        } else {
            self.encryptionKey = encryptionKey
        }
        self.mac = mac
        self.ssc = ssc
    }
    
    // MARK: - Encryption Methods
    
    func asn1Length(data: Data, len: inout Int, o: inout Int) {
        let bytes = data.bytes
        let mutableData = Data(bytes)
        
        if bytes[0] <= 0x7F {
            let lenValue = mutableData.subdata(in: 0..<1).withUnsafeBytes { buffer -> UInt8 in
                buffer.load(as: UInt8.self)
            }
            
            len = Int(lenValue)
            o = 1
            return
        }
        
        if bytes[0] == 0x81 {
            let lenValue = mutableData.subdata(in: 1..<2).withUnsafeBytes { buffer -> UInt8 in
                buffer.load(as: UInt8.self)
            }
            
            len = Int(lenValue)
            o = 2
            return
        }
        
        if bytes[0] == 0x82 {
            let lenValue = mutableData.subdata(in: 1..<3).withUnsafeBytes { buffer -> UInt16 in
                buffer.load(as: UInt16.self)
            }
            
            len = Int(lenValue.bigEndian)
            o = 3
            return
        }
    }
    
    func encrypt(apdu: NFCISO7816APDU) -> NFCISO7816APDU? {
        let headerBytes: [UInt8] = [0x0c, apdu.instructionCode, apdu.p1Parameter, apdu.p2Parameter]
        let cmdHeader = Data(headerBytes).nfcAddPadding()
        let do87: Data!
        let do97: Data!
        
        if apdu.data != nil {
            if let do87Data = self.buildD087(apdu: apdu) {
                do87 = do87Data
            } else {
                return nil
            }
        } else {
            do87 = Data()
        }
        
        if apdu.expectedResponseLength > 0 {
            if let do97Data = self.buildD097(apdu: apdu) {
                do97 = do97Data
            } else {
                return nil
            }
        } else {
            do97 = Data()
        }
        
        // Update SSC
        self.ssc = self.incSSC()
        
        let message = self.ssc + cmdHeader + do87 + do97
        let messageWithPadding = message.nfcAddPadding()
        let cc = messageWithPadding.nfcMACKey(key: self.mac)
        
        let do8eHeader = IONFCBinary8Model(prefix: 0x8E, length: UInt8(cc.count))
        let do8e = IOBinaryMapper.toBinary(header: do8eHeader, content: cc)
        
        var size = UInt8(do87.count + do97.count + do8e.count)
        
        var protectedAPDU = Data()
        protectedAPDU.append(cmdHeader[0..<4])
        protectedAPDU.append(Data(bytes: &size, count: MemoryLayout<UInt8>.size))
        protectedAPDU.append(do87)
        protectedAPDU.append(do97)
        protectedAPDU.append(do8e)
        protectedAPDU.append(contentsOf: [0x00])
        
        IOLogger.verbose("NFC: Encrypt")
        return NFCISO7816APDU(data: protectedAPDU)
    }
    
    func decrypt(rapdu: IONFCTagResponseModel) -> IONFCTagResponseModel? {
        // Check for a SM error
        if rapdu.sw1 != 0x90 || rapdu.sw2 != 0x00 {
            return rapdu
        }
        
        var do87 = Data()
        var do87Data = Data()
        var do99 = Data()
        var offset = 0
        
        var rapduData = rapdu.data
        rapduData.append(contentsOf: [rapdu.sw1, rapdu.sw2])
        let bytes = rapduData.bytes
        
        // DO87
        // Mandatory if data is returned, otherwise absent
        if bytes[0] == 0x87 {
            var len = 0
            var o = 0
            self.asn1Length(data: rapduData[1..<rapduData.count], len: &len, o: &o)
            offset = 1 + o
            
            if bytes[offset] != 0x1 {
                return nil
            }
            
            do87 = rapduData[0..<offset + len]
            do87Data = rapduData[offset + 1..<offset + len]
            offset += len
        }
        
        // DO'99'
        // Mandatory, only absent if SM error occurs
        do99 = rapduData[offset..<offset + 4]
        let sw1 = bytes[offset + 2]
        let sw2 = bytes[offset + 3]
        offset += 4
        
        let do99Bytes = do99.bytes
        if do99Bytes[0] != 0x99 && do99Bytes[1] != 0x02 {
            // SM error, return the error code
            return IONFCTagResponseModel(sw1: sw1, sw2: sw2, data: Data())
        }
        
        // DO'8E'
        // Mandatory if DO'87' and/or DO'99' is present
        if bytes[offset] == 0x8E {
            let ccLength = rapduData[offset + 1..<offset + 2].withUnsafeBytes { buffer -> UInt8 in
                buffer.load(as: UInt8.self)
            }
            
            let cc = rapduData[offset + 2..<offset + 2 + Int(ccLength)]
            
            // ChechCC
            self.ssc = self.incSSC()
            
            let encryptionKey = (self.ssc + do87 + do99).nfcAddPadding()
            let ccb = encryptionKey.nfcMACKey(key: self.mac)
            
            if cc != ccb {
                return nil
            }
        }
        
        let responseData: Data
        if
            !do87Data.isEmpty,
            let decryptedData = IOTripleDESUtility.decrypt(key: self.encryptionKey, iv: Data.nfcIV(), message: do87Data)
        {
            // There is a payload
            responseData = decryptedData.nfcRemovePadding()
        } else {
            responseData = Data()
        }
        
        IOLogger.verbose("NFC: Decrypt")
        return IONFCTagResponseModel(sw1: sw1, sw2: sw2, data: responseData)
    }
    
    // MARK: - Helper Methods
    
    private func buildD087(apdu: NFCISO7816APDU) -> Data? {
        let adpuWithPadding = apdu.data!.nfcAddPadding()
        
        guard let encryptedData = IOTripleDESUtility.encrypt(key: self.encryptionKey, iv: Data.nfcIV(), message: adpuWithPadding) else { return nil }
        
        var mutableEncryptedData = encryptedData
        mutableEncryptedData.insert(0x01, at: 0)

        let binaryHeader = IONFCBinary8Model(prefix: 0x87, length: UInt8(mutableEncryptedData.count))
        return IOBinaryMapper.toBinary(header: binaryHeader, content: mutableEncryptedData)
    }
    
    private func buildD097(apdu: NFCISO7816APDU) -> Data? {
        let expectedLength = apdu.expectedResponseLength

        let lengthBinaryString = String(format: "%02lx", expectedLength)
        var dataOfExpextedLength = Data()
        dataOfExpextedLength.append(contentsOf: Data(fromHexString: lengthBinaryString))
        
        if expectedLength == 256 || expectedLength == 65536 {
            dataOfExpextedLength = Data([0x00])
            
            if expectedLength > 256 {
                dataOfExpextedLength.append(contentsOf: [0x00])
            }
        }
        
        let binaryHeader = IONFCBinary8Model(prefix: 0x97, length: UInt8(dataOfExpextedLength.count))
        return IOBinaryMapper.toBinary(header: binaryHeader, content: dataOfExpextedLength)
    }
    
    private func incSSC() -> Data {
        let sscHex = self.ssc.toHexString()
        let sscVal = strtoul(sscHex, nil, 16)
        
        let newSscVal = sscVal + 1
        return Data(fromHexString: String(format: "%lx", newSscVal))
    }
}
