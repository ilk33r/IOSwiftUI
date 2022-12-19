//
//  IOISO7816KeyDerivation.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

final class IOISO7816KeyDerivation {
    
    // MARK: - Privates
    
    private var encryptionKeyType: Data
    private var macKeyType: Data
    
    private var keyEncryption: Data?
    private var keyMac: Data?
    private var rndICC: Data?
    private var rndIFD: Data?
    private var kifd: Data?
    
    // MARK: - Initialization Methods
    
    init(mrz: String) throws {
        var encryptionKeyTypeBytes: [UInt8] = [0, 0, 0, 1]
        var macKeyTypeBytes: [UInt8] = [0, 0, 0, 2]
        self.encryptionKeyType = Data(bytes: &encryptionKeyTypeBytes, count: encryptionKeyTypeBytes.count)
        self.macKeyType = Data(bytes: &macKeyTypeBytes, count: macKeyTypeBytes.count)
        
        try self.createBasicAccessKeys(mrz: mrz)
    }
    
    // MARK: - KDF Methods
    
    func authenticationData(rndICC: Data) -> Data? {
        self.rndICC = rndICC
        
        let rndIFD = self.generateRandom(size: 8)
        let kifd = self.generateRandom(size: 16)
        let plainEIFD = rndIFD + rndICC + kifd
        let tripleDESKey = self.keyEncryption! + self.keyEncryption![0..<8]
        
        guard let eifd = IOTripleDESUtility.encrypt(key: tripleDESKey, iv: Data.nfcIV(), message: plainEIFD) else { return nil }
        let eifdWithPadding = eifd.nfcAddPadding()
        let mifd = eifdWithPadding.nfcMACKey(key: self.keyMac!)
        
        self.rndIFD = rndIFD
        self.kifd = kifd
        
        return eifd + mifd
    }
    
    // MARK: - Helper Methods
    
    private func createBasicAccessKeys(mrz: String) throws {
        guard let mrzData = mrz.data(using: .utf8) else { throw IONFCError.keyDerivation }
        guard let mrzHash = IOSHAUtilities.sha1(data: mrzData) else { throw IONFCError.keyDerivation }
        let seed = mrzHash.subdata(in: 0..<16)
        
        self.keyEncryption = self.keyDerivation(kseed: seed, type: self.encryptionKeyType)
        self.keyMac = self.keyDerivation(kseed: seed, type: self.macKeyType)
    }
    
    private func generateRandom(size: Int) -> Data {
        var bytes = [UInt8]()
        
        for _ in 0..<size {
            bytes.append(UInt8.random(in: 0..<UInt8(UINT8_MAX)))
        }
        
        return Data(bytes: &bytes, count: size)
    }
    
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
        
        return Data(bytes: &bytes, count: bytes.count)
    }

}
