//
//  IOISO7816TagCommunicationUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import CoreNFC
import Foundation
import IOSwiftUIInfrastructure

final class IOISO7816TagCommunicationUtilities {
    
    // MARK: - Defs
    
    typealias CompleteHandler = (_ response: IONFCTagResponseModel?, _ error: IONFCError?) -> Void
    
    // MARK: - Privates
    
    private let nfcTag: NFCISO7816Tag
    
    private var encryption: IOISO7816Encryption?
    private var keyDerivation: IOISO7816KeyDerivation?
    
    // MARK: - Initialization Methods
    
    init(tag: NFCISO7816Tag) {
        self.nfcTag = tag
    }
    
    // MARK: - Utils
    
    func authenticateTagWithMRZ(
        mrz: String,
        handler: @escaping CompleteHandler
    ) throws {
        // Initialize key derivation
        self.encryption = nil
        self.keyDerivation = try IOISO7816KeyDerivation(mrz: mrz)
        
        // Get challange
        self.getChallenge(handler: handler)
    }
    
    func readDataGroup(
        type: IONFCDataGroup,
        handler: @escaping CompleteHandler
    ) {
        let dataGroupFieldMap = type.fieldMaps()
        
        let command = NFCISO7816APDU(
            instructionClass: 0x00,
            instructionCode: 0xA4,
            p1Parameter: 0x02,
            p2Parameter: 0x0C,
            data: Data(dataGroupFieldMap),
            expectedResponseLength: -1
        )
        self.send(command: command) { [weak self] _, error in
            if let error {
                handler(nil, error)
                return
            }
            
            // Read first 4 bytes of header to see how big the data structure is
            var data: [UInt8] = [ 0x00, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x04 ]
            let commandData = Data(data)
            let command = NFCISO7816APDU(data: commandData)!
            self?.send(command: command) { [weak self] response, error in
                if let error {
                    handler(nil, error)
                    return
                }
                
                guard let data = response?.data else {
                    handler(nil, .tagResponse)
                    return
                }
                
                var lefttoRead = 0
                var len = 0
                var o = 0
                self?.encryption?.asn1Length(data: data, len: &len, o: &o)
                lefttoRead = len
                let offset = o + 1
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func getChallenge(handler: @escaping CompleteHandler) {
        // Create authentication command
        let command = NFCISO7816APDU(
            instructionClass: 0x00,
            instructionCode: 0x84,
            p1Parameter: 0,
            p2Parameter: 0,
            data: Data(),
            expectedResponseLength: 8
        )
        
        self.send(command: command) { [weak self] response, error in
            // Check response is success
            if let error {
                handler(nil, error)
                return
            }
            
            // Create authentication data
            guard let data = response?.data else {
                handler(nil, .authentication)
                return
            }
            
            guard let authenticationData = self?.keyDerivation?.authenticationData(rndICC: data) else {
                handler(nil, .authentication)
                return
            }
            
            // Mutual authenticate
            self?.mutualAuthentication(data: authenticationData, handler: handler)
        }
    }
    
    private func mutualAuthentication(data: Data, handler: @escaping CompleteHandler) {
        // Create authentication command
        let command = NFCISO7816APDU(
            instructionClass: 0x00,
            instructionCode: 0x82,
            p1Parameter: 0,
            p2Parameter: 0,
            data: data,
            expectedResponseLength: 40
        )
        
        self.send(command: command) { [weak self] response, error in
            // Check response is success
            if let error {
                handler(nil, error)
                return
            }
            
            guard let responseData = response?.data else {
                handler(nil, .authentication)
                return
            }
            
            // Mutual authenticate
            var encryptionKey = Data()
            var mac = Data()
            var ssc = Data()
            
            do {
                try self?.keyDerivation?.createSessionKeys(authenticationData: responseData, encryptionKey: &encryptionKey, mac: &mac, ssc: &ssc)
                self?.encryption = IOISO7816Encryption(encryptionKey: encryptionKey, mac: mac, ssc: ssc)
                handler(nil, nil)
                return
            } catch let error {
                if let error = error as? IONFCError {
                    handler(nil, error)
                    return
                }
            }
            
            handler(nil, .authentication)
        }
    }
    
    private func send(command: NFCISO7816APDU, handler: @escaping CompleteHandler) {
        var toSend = command
        
        // Check authentication succeed
        if
            let encryption = self.encryption,
            let encryptedMessage = encryption.encrypt(apdu: command) {
            toSend = encryptedMessage
        }
        
        self.nfcTag.sendCommand(apdu: toSend) { [weak self] responseData, sw1, sw2, error in
            if let error = error as? NSError {
                if error.code == NFCReaderError.readerTransceiveErrorTagConnectionLost.rawValue {
                    // Call handler
                    handler(nil, .connectionLost)
                } else {
                    // Call handler
                    handler(nil, .tagRead)
                }
                
                // Do nothing
                return
            }
            
            var response = IONFCTagResponseModel(sw1: sw1, sw2: sw2, data: responseData)
            if
                let encryption = self?.encryption,
                let decryptedResponse = encryption.decrypt(rapdu: response)
            {
                response = decryptedResponse
            }
            
            if response.sw1 == 0x90 && response.sw2 == 0x00 {
                // Call handler
                handler(response, nil)
                
                // Do nothing
                return
            }
            
            // Create an error
            if (response.sw1 == 0x63 && response.sw2 == 0x00) || (response.sw1 == 0x69 && response.sw2 == 0x82) {
                handler(nil, .authentication)
            } else {
                if response.sw1 == 0x69 && response.sw2 == 0x88 {
                    IOLogger.error("NFC: Incorrect secure messaging (SM) data object")
                } else {
                    IOLogger.error("NFC: Unkown")
                }
                
                handler(nil, .tagResponse)
            }
        }
    }

}
