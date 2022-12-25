//
//  IOSwiftUINFCAuthenticationTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.12.2022.
//

import CoreNFC
import XCTest
@testable import IOSwiftUISupportNFC
@testable import IOSwiftUIInfrastructure

final class IOSwiftUINFCAuthenticationTests: XCTestCase {
    
    private var encryptionKeyType: Data!
    private var macKeyType: Data!
    
    override func setUp() {
        super.setUp()
        
        let encryptionKeyTypeBytes: [UInt8] = [0, 0, 0, 1]
        let macKeyTypeBytes: [UInt8] = [0, 0, 0, 2]
        self.encryptionKeyType = Data(encryptionKeyTypeBytes)
        self.macKeyType = Data(macKeyTypeBytes)
    }
    
    func testCreateAccessKey() {
        let mrzHash = Data(fromHexString: "4ec0ade09a3680cff278c6e528b040d0e8a33ed6")
        let seed = mrzHash.subdata(in: 0..<16)
        XCTAssertEqual(seed.toHexString(), "4ec0ade09a3680cff278c6e528b040d0")
        
        var keyEncryption = self.keyDerivation(kseed: seed, type: self.encryptionKeyType)
        XCTAssertEqual(keyEncryption.toHexString(), "c4d3ae70c42fd3a8580bfdad92d30746")
        if keyEncryption.count == 16 {
            keyEncryption = keyEncryption + keyEncryption.subdata(in: 0..<8)
        }
        XCTAssertEqual(keyEncryption.toHexString(), "c4d3ae70c42fd3a8580bfdad92d30746c4d3ae70c42fd3a8")
        
        let keyMac = self.keyDerivation(kseed: seed, type: self.macKeyType)
        XCTAssertEqual(keyMac.toHexString(), "f789e0efdf45c49b7f62e62994e6c157")
    }
    
    func testAuthenticationData() {
        let rndICC = Data(fromHexString: "7799dde2cdb0f7dc")
        
        let rndIFD = Data(fromHexString: "8732da670b32298b")
        let kifd = Data(fromHexString: "1a631f20f30415e0454f80b30c62c71e")
        let plainEIFD = rndIFD + rndICC + kifd
        XCTAssertEqual(plainEIFD.toHexString(), "8732da670b32298b7799dde2cdb0f7dc1a631f20f30415e0454f80b30c62c71e")
        
        let keyEncryption = Data(fromHexString: "c4d3ae70c42fd3a8580bfdad92d30746c4d3ae70c42fd3a8")
        let eifd = IOTripleDESUtility.encrypt(key: keyEncryption, iv: Data.nfcIV(), message: plainEIFD)
        XCTAssertNotNil(eifd)
        XCTAssertEqual(eifd?.toHexString(), "bb927c212720a632e5f361a24f8ccc80a33441c68aa329bef0356b5a4e9fe26b")
        
        let eifdWithPadding = eifd!.nfcAddPadding()
        XCTAssertEqual(eifdWithPadding.toHexString(), "bb927c212720a632e5f361a24f8ccc80a33441c68aa329bef0356b5a4e9fe26b8000000000000000")
        let keyMac = Data(fromHexString: "f789e0efdf45c49b7f62e62994e6c157")
        let mifd = eifdWithPadding.nfcMACKey(key: keyMac)
        XCTAssertEqual(mifd.toHexString(), "b03a2ab8fcb15a63")

        let authenticationData = eifd! + mifd
        XCTAssertEqual(authenticationData.toHexString(), "bb927c212720a632e5f361a24f8ccc80a33441c68aa329bef0356b5a4e9fe26bb03a2ab8fcb15a63")
    }
    
    func testSessionKey() throws {
        let plainAuthenticationData = Data(fromHexString: "86d3eb1988a453ba6bcf854e0f48bbfefa74c6d27e530c45964265d0d33f74d1")
        
        let keyEncryption = Data(fromHexString: "c4d3ae70c42fd3a8580bfdad92d30746c4d3ae70c42fd3a8")
        guard let response = IOTripleDESUtility.decrypt(key: keyEncryption, iv: Data.nfcIV(), message: plainAuthenticationData) else { throw IONFCError.authentication }
        XCTAssertEqual(response.toHexString(), "7799dde2cdb0f7dc8732da670b32298bc4728aa9470277ab2809ad0e369278f8")
        
        let responseKICC = response.subdata(in: 16..<32)
        XCTAssertEqual(responseKICC.toHexString(), "c4728aa9470277ab2809ad0e369278f8")
        
        let kifd = Data(fromHexString: "1a631f20f30415e0454f80b30c62c71e")
        let kseed = self.xor(kifd: kifd, kicc: responseKICC)
        XCTAssertEqual(kseed.toHexString(), "de119589b406624b6d462dbd3af0bfe6")
        
        let tempksenc = self.keyDerivation(kseed: kseed, type: self.encryptionKeyType)
        XCTAssertEqual(tempksenc.toHexString(), "b3e067b9a892e0464f67a7c2ae628ff2")
        
        let tempksmac = self.keyDerivation(kseed: kseed, type: self.macKeyType)
        XCTAssertEqual(tempksmac.toHexString(), "d5e3d3bc5d918657f834dcd698f2e6e0")
        
        let rndICC = Data(fromHexString: "7799dde2cdb0f7dc")
        let subRndIccStartIndex = rndICC.count - 4
        let subRndIcc = rndICC.subdata(in: subRndIccStartIndex..<(subRndIccStartIndex + 4))
        XCTAssertEqual(subRndIcc.toHexString(), "cdb0f7dc")
        
        let rndIFD = Data(fromHexString: "8732da670b32298b")
        let subRndIfdStartIndex = rndIFD.count - 4
        let subRndIfd = rndIFD.subdata(in: subRndIfdStartIndex..<(subRndIfdStartIndex + 4))
        XCTAssertEqual(subRndIfd.toHexString(), "0b32298b")
    }
    
    func testEncrypt1() {
        let apdu = NFCISO7816APDU(
            instructionClass: 0x00,
            instructionCode: 0xA4,
            p1Parameter: 0x02,
            p2Parameter: 0x0C,
            data: Data([0x01, 0x1E]),
            expectedResponseLength: -1
        )
        
        let headerBytes: [UInt8] = [0x0c, apdu.instructionCode, apdu.p1Parameter, apdu.p2Parameter]
        let cmdHeader = Data(headerBytes).nfcAddPadding()
        XCTAssertEqual(cmdHeader.toHexString(), "0ca4020c80000000")
        
        let do87: Data!
        let do97: Data!
        
        if apdu.data != nil {
            if let do87Data = self.buildD087(apdu: apdu) {
                do87 = do87Data
            } else {
                return
            }
        } else {
            do87 = Data()
        }
        
        if apdu.expectedResponseLength > 0 {
            if let do97Data = self.buildD097(apdu: apdu) {
                do97 = do97Data
            } else {
                return
            }
        } else {
            do97 = Data()
        }
        
        XCTAssertEqual(do87.toHexString(), "870901b13c658fc73028c2")
        XCTAssertEqual(do97.toHexString(), "")
        
        // Update SSC
        var ssc = Data(fromHexString: "b253d0535c5613a8")
        ssc = self.incSSC(ssc: ssc)
        XCTAssertEqual(ssc.toHexString(), "b253d0535c5613a9")
        
        let message = ssc + cmdHeader + do87 + do97
        let messageWithPadding = message.nfcAddPadding()
        XCTAssertEqual(messageWithPadding.toHexString(), "b253d0535c5613a90ca4020c80000000870901b13c658fc73028c28000000000")
        let mac = Data(fromHexString: "4926987cceb9e3c41f10eca26249abfb")
        let cc = messageWithPadding.nfcMACKey(key: mac)
        XCTAssertEqual(cc.toHexString(), "d432a170da6e4957")
        
        let do8eHeader = IONFCBinary8Model(prefix: 0x8E, length: UInt8(cc.count))
        let do8e = IOBinaryMapper.toBinary(header: do8eHeader, content: cc)
        XCTAssertEqual(do8e.toHexString(), "8e08d432a170da6e4957")
        
        var size = UInt8(do87.count + do97.count + do8e.count)
        
        var protectedAPDU = Data()
        protectedAPDU.append(cmdHeader[0..<4])
        protectedAPDU.append(Data(bytes: &size, count: MemoryLayout<UInt8>.size))
        protectedAPDU.append(do87)
        protectedAPDU.append(do97)
        protectedAPDU.append(do8e)
        protectedAPDU.append(contentsOf: [0x00])
        XCTAssertEqual(protectedAPDU.toHexString(), "0ca4020c15870901b13c658fc73028c28e08d432a170da6e495700")
    }
    
    func testEncrypt2() {
        let apduData: [UInt8] = [0x00, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x04]
        let apdu = NFCISO7816APDU(data: Data(apduData))!
        
        let headerBytes: [UInt8] = [0x0c, apdu.instructionCode, apdu.p1Parameter, apdu.p2Parameter]
        let cmdHeader = Data(headerBytes).nfcAddPadding()
        XCTAssertEqual(cmdHeader.toHexString(), "0cb0000080000000")
        
        let do87: Data!
        let do97: Data!
        
        if apdu.data != nil {
            if let do87Data = self.buildD087(apdu: apdu) {
                do87 = do87Data
            } else {
                return
            }
        } else {
            do87 = Data()
        }
        
        if apdu.expectedResponseLength > 0 {
            if let do97Data = self.buildD097(apdu: apdu) {
                do97 = do97Data
            } else {
                return
            }
        } else {
            do97 = Data()
        }
        
        XCTAssertEqual(do87.toHexString(), "")
        XCTAssertEqual(do97.toHexString(), "970104")
        
        // Update SSC
        var ssc = Data(fromHexString: "cdb0f7dc0b32298d")
        ssc = self.incSSC(ssc: ssc)
        XCTAssertEqual(ssc.toHexString(), "cdb0f7dc0b32298e")
        
        let message = ssc + cmdHeader + do87 + do97
        let messageWithPadding = message.nfcAddPadding()
        XCTAssertEqual(messageWithPadding.toHexString(), "cdb0f7dc0b32298e0cb00000800000009701048000000000")
        
        let mac = Data(fromHexString: "d5e3d3bc5d918657f834dcd698f2e6e0")
        let cc = messageWithPadding.nfcMACKey(key: mac)
        XCTAssertEqual(cc.toHexString(), "883252b13e20d901")
        
        let do8eHeader = IONFCBinary8Model(prefix: 0x8E, length: UInt8(cc.count))
        let do8e = IOBinaryMapper.toBinary(header: do8eHeader, content: cc)
        XCTAssertEqual(do8e.toHexString(), "8e08883252b13e20d901")
        
        var size = UInt8(do87.count + do97.count + do8e.count)
        
        var protectedAPDU = Data()
        protectedAPDU.append(cmdHeader[0..<4])
        protectedAPDU.append(Data(bytes: &size, count: MemoryLayout<UInt8>.size))
        protectedAPDU.append(do87)
        protectedAPDU.append(do97)
        protectedAPDU.append(do8e)
        protectedAPDU.append(contentsOf: [0x00])
        XCTAssertEqual(protectedAPDU.toHexString(), "0cb000000d9701048e08883252b13e20d90100")
    }
    
    func testDecrypt1() {
        // Check for a SM error
        var do87 = Data()
        var do87Data = Data()
        var do99 = Data()
        var offset = 0
        
        var rapduData = Data(fromHexString: "990290008e089ff10ac2509f39f2")
        rapduData.append(contentsOf: [0x90, 0x00])
        XCTAssertEqual(rapduData.toHexString(), "990290008e089ff10ac2509f39f29000")
        
        let bytes = rapduData.bytes
        
        // DO87
        // Mandatory if data is returned, otherwise absent
        if bytes[0] == 0x87 {
            var len = 0
            var o = 0
            self.asn1Length(data: rapduData[1..<rapduData.count], len: &len, o: &o)
            offset = 1 + o
            
            if bytes[offset] != 0x1 {
                return
            }
            
            do87 = rapduData[0..<offset + len]
            do87Data = rapduData[offset + 1..<len]
            offset += len
        }
        
        XCTAssertEqual(do87.toHexString(), "")
        XCTAssertEqual(do87Data.toHexString(), "")
        
        // DO'99'
        // Mandatory, only absent if SM error occurs
        do99 = rapduData[offset..<offset + 4]
        offset += 4
        
        let do99Bytes = do99.bytes
        XCTAssertEqual(do99Bytes[0], 0x99)
        XCTAssertEqual(do99Bytes[1], 0x02)
        XCTAssertEqual(do99.toHexString(), "99029000")
        
        // DO'8E'
        // Mandatory if DO'87' and/or DO'99' is present
        if bytes[offset] == 0x8E {
            let ccLength = rapduData[offset + 1..<offset + 2].withUnsafeBytes { buffer -> UInt8 in
                buffer.load(as: UInt8.self)
            }
            
            let cc = rapduData[offset + 2..<offset + 2 + Int(ccLength)]
            XCTAssertEqual(cc.toHexString(), "9ff10ac2509f39f2")
            
            // ChechCC
            var ssc = Data(fromHexString: "cdb0f7dc0b32298c")
            ssc = self.incSSC(ssc: ssc)
            XCTAssertEqual(ssc.toHexString(), "cdb0f7dc0b32298d")
            
            let encryptionKey = (ssc + do87 + do99).nfcAddPadding()
            XCTAssertEqual(encryptionKey.toHexString(), "cdb0f7dc0b32298d9902900080000000")
            
            let mac = Data(fromHexString: "d5e3d3bc5d918657f834dcd698f2e6e0")
            let ccb = encryptionKey.nfcMACKey(key: mac)
            XCTAssertEqual(ccb.toHexString(), "9ff10ac2509f39f2")
            XCTAssertEqual(cc, ccb)
        }
    }
    
    func testDecrypt2() {
        // Check for a SM error
        var do87 = Data()
        var do87Data = Data()
        var do99 = Data()
        var offset = 0
        
        var rapduData = Data(fromHexString: "870901912b918be6659117990290008e08570200ea309c7454")
        rapduData.append(contentsOf: [0x90, 0x00])
        XCTAssertEqual(rapduData.toHexString(), "870901912b918be6659117990290008e08570200ea309c74549000")
        
        let bytes = rapduData.bytes
        
        // DO87
        // Mandatory if data is returned, otherwise absent
        if bytes[0] == 0x87 {
            var len = 0
            var o = 0
            self.asn1Length(data: rapduData[1..<rapduData.count], len: &len, o: &o)
            XCTAssertEqual(len, 9)
            XCTAssertEqual(o, 1)
            offset = 1 + o
            
            if bytes[offset] != 0x1 {
                return
            }
            
            do87 = rapduData[0..<offset + len]
            do87Data = rapduData[offset + 1..<offset + len]
            offset += len
        }
        
        XCTAssertEqual(do87.toHexString(), "870901912b918be6659117")
        XCTAssertEqual(do87Data.toHexString(), "912b918be6659117")
        
        // DO'99'
        // Mandatory, only absent if SM error occurs
        do99 = rapduData[offset..<offset + 4]
        offset += 4
        
        let do99Bytes = do99.bytes
        XCTAssertEqual(do99Bytes[0], 0x99)
        XCTAssertEqual(do99Bytes[1], 0x02)
        XCTAssertEqual(do99.toHexString(), "99029000")
        
        // DO'8E'
        // Mandatory if DO'87' and/or DO'99' is present
        if bytes[offset] == 0x8E {
            let ccLength = rapduData[offset + 1..<offset + 2].withUnsafeBytes { buffer -> UInt8 in
                buffer.load(as: UInt8.self)
            }
            
            let cc = rapduData[offset + 2..<offset + 2 + Int(ccLength)]
            XCTAssertEqual(cc.toHexString(), "570200ea309c7454")
            
            // ChechCC
            var ssc = Data(fromHexString: "cdb0f7dc0b32298e")
            ssc = self.incSSC(ssc: ssc)
            XCTAssertEqual(ssc.toHexString(), "cdb0f7dc0b32298f")
            
            let encryptionKey = (ssc + do87 + do99).nfcAddPadding()
            XCTAssertEqual(encryptionKey.toHexString(), "cdb0f7dc0b32298f870901912b918be66591179902900080")
            
            let mac = Data(fromHexString: "d5e3d3bc5d918657f834dcd698f2e6e0")
            let ccb = encryptionKey.nfcMACKey(key: mac)
            XCTAssertEqual(ccb.toHexString(), "570200ea309c7454")
            XCTAssertEqual(cc, ccb)
        }
        
        let encKey = Data(fromHexString: "b3e067b9a892e0464f67a7c2ae628ff2b3e067b9a892e046")
        if
            !do87Data.isEmpty,
            let decryptedData = IOTripleDESUtility.decrypt(key: encKey, iv: Data.nfcIV(), message: do87Data)
        {
            // There is a payload
            let responseData = decryptedData.nfcRemovePadding()
            XCTAssertEqual(decryptedData.toHexString(), "60185f0180000000")
            XCTAssertEqual(responseData.toHexString(), "60185f01")
        }
    }
    
    // MARK: - KDF
    
    private func keyDerivation(kseed: Data, type: Data) -> Data {
        let encryptedData = IOSHAUtilities.sha1(data: kseed + type)!
        
        let ka = encryptedData.subdata(in: 0..<8)
        let kb = encryptedData.subdata(in: 8..<16)
        
        let newKa = self.desParity(data: ka)
        let newKb = self.desParity(data: kb)
        
        return newKa + newKb
    }

    private func desParity(data: Data) -> Data {
        var bytes = data.bytes
        
        for i in 0..<data.count {
            let y = bytes[i] & 0xfe
            var parity: UInt8 = 0
            
            for j in 0..<8 {
                parity += y >> j & 1
            }
            
            bytes[i] = y + (parity % 2 == 0 ? 1 : 0)
        }
        
        return Data(bytes)
    }
    
    private func xor(kifd: Data, kicc: Data) -> Data {
        let kifdBytes = kifd.bytes
        let kiccBytes = kicc.bytes
        
        var kseed = [UInt8]()
        
        kifdBytes.enumerated().forEach { it in
            let xorByte = it.element ^ kiccBytes[it.offset]
            kseed.append(xorByte)
        }
        
        return Data(kseed)
    }
    
    // MARK: - Encryption
    
    private func asn1Length(data: Data, len: inout Int, o: inout Int) {
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
            
            len = Int(lenValue)
            o = 3
            return
        }
    }
    
    private func buildD087(apdu: NFCISO7816APDU) -> Data? {
        let adpuWithPadding = apdu.data!.nfcAddPadding()
        
        let keyEncryption = Data(fromHexString: "b340138ab9bcf1d334fbec5120fbe9cbb340138ab9bcf1d3")
        guard let encryptedData = IOTripleDESUtility.encrypt(key: keyEncryption, iv: Data.nfcIV(), message: adpuWithPadding) else { return nil }
        
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
            dataOfExpextedLength.append(contentsOf: [0x00])
            
            if expectedLength > 256 {
                dataOfExpextedLength.append(contentsOf: [0x00])
            }
        }
        
        let binaryHeader = IONFCBinary8Model(prefix: 0x97, length: UInt8(dataOfExpextedLength.count))
        return IOBinaryMapper.toBinary(header: binaryHeader, content: dataOfExpextedLength)
    }
    
    private func incSSC(ssc: Data) -> Data {
        let sscHex = ssc.toHexString()
        let sscVal = strtoul(sscHex, nil, 16)
        
        let newSscVal = sscVal + 1
        return Data(fromHexString: String(format: "%lx", newSscVal))
    }
}
