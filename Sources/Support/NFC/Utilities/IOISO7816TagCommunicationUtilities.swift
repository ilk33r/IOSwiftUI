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
    
    typealias CompleteHandler = (_ data: IONFCTagResponseModel?, _ error: IONFCError?) -> Void
    
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
    
    // MARK: - Helper Methods
    
    private func getChallenge(handler: @escaping CompleteHandler) {
        // Create authentication command
        let command = NFCISO7816APDU(
            instructionClass: 00,
            instructionCode: 0x84,
            p1Parameter: 0,
            p2Parameter: 0,
            data: Data(),
            expectedResponseLength: 8
        )
        
        self.send(command: command) { [weak self] data, error in
            // Check response is success
            if let error {
                handler(nil, error)
                return
            }
            
            // Create authentication data
            guard let data = data else {
                handler(nil, .authentication)
                return
            }
            
            guard let authenticationData = self?.keyDerivation?.authenticationData(rndICC: data.data) else {
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
            instructionClass: 00,
            instructionCode: 0x82,
            p1Parameter: 0,
            p2Parameter: 0,
            data: data,
            expectedResponseLength: 40
        )
        
        self.send(command: command) { [weak self] data, error in
            // Check response is success
            if let error {
                handler(nil, error)
                return
            }
            
            IOLogger.info("sdf \(data)")
        }
    }
    
    private func send(command: NFCISO7816APDU, handler: @escaping CompleteHandler) {
        var toSend = command
        
        // Check authentication succeed
        if let encryption = self.encryption {
            /*NFCISO7816APDU *securedMessage = [self.secureMessaging protectMessageWithAPDU:command];
            if (securedMessage) {
                toSend = securedMessage;
            }
            */
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
            if let encryption = self?.encryption {
                /*
                VPIDNFCTagResponseModel *decryptedResponse = [weakSelf.secureMessaging unprotectMessageWithAPDU:response];
                if (decryptedResponse) {
                    response = decryptedResponse;
                }
                 */
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
                handler(nil, .tagResponse)
            }
        }
    }

}
