//
//  IOISO7816DG1Model.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DG1Model {
    
    // MARK: - Properties
    
    public let documentCode: String
    public let issuingState: String
    public let documentNumber: String
    public let documentNumberCheckDigit: String
    public let optionalData1: String
    public let dateOfBirth: String
    public let sex: String
    public let dateOfExpiry: String
    public let nationality: String
    public let optionalData2: String
    public let surname: String
    public let name: String
    public let mrzFullString: String
    
    // MARK: - Defs
    
    private struct TagHeader {
        
        let prefix: UInt8
        let length: UInt8
        let tag1: UInt8
        let tag2: UInt8
        let mrzLength: UInt8
    }
    
    // MARK: - Initialization Methods
    
    public init(data: Data) throws {
        var parsedData = data
        var parsedDataSize = 0
        
        let header = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if header.prefix != 0x61 {
            throw IONFCParserError.invalidData
        }
        
        if header.tag1 != 0x5f && header.tag2 != 0x1f {
            throw IONFCParserError.invalidData
        }
        
        let mrzFullString = String(data: parsedData, encoding: .utf8) ?? ""
        self.mrzFullString = mrzFullString
        
        if mrzFullString.count != header.mrzLength {
            throw IONFCParserError.invalidData
        }
        
        let documentCode = mrzFullString.substring(start: 0, count: 2)
        self.documentCode = documentCode.replacingOccurrences(of: "<", with: "")
        
        let issuingState = mrzFullString.substring(start: 2, count: 3)
        self.issuingState = issuingState.replacingOccurrences(of: "<", with: "")
        
        let documentNumber = mrzFullString.substring(start: 5, count: 9)
        self.documentNumber = documentNumber.replacingOccurrences(of: "<", with: "")
        
        let documentNumberCheckDigit = mrzFullString.substring(start: 14, count: 1)
        self.documentNumberCheckDigit = documentNumberCheckDigit.replacingOccurrences(of: "<", with: "")
        
        let optionalData1 = mrzFullString.substring(start: 15, count: 15)
        self.optionalData1 = optionalData1.replacingOccurrences(of: "<", with: "")
        
        let dateOfBirth = mrzFullString.substring(start: 30, count: 6)
        self.dateOfBirth = dateOfBirth.replacingOccurrences(of: "<", with: "")
        
        let sex = mrzFullString.substring(start: 37, count: 1)
        self.sex = sex.replacingOccurrences(of: "<", with: "")
        
        let dateOfExpiry = mrzFullString.substring(start: 38, count: 6)
        self.dateOfExpiry = dateOfExpiry.replacingOccurrences(of: "<", with: "")
        
        let nationality = mrzFullString.substring(start: 45, count: 3)
        self.nationality = nationality.replacingOccurrences(of: "<", with: "")
        
        let optionalData2 = mrzFullString.substring(start: 48, count: 11)
        self.optionalData2 = optionalData2.replacingOccurrences(of: "<", with: "")
        
        let holderName = mrzFullString.substring(start: 60, count: 30)
        let holderNameParts = holderName.components(separatedBy: "<<")
        
        self.surname = holderNameParts[0].replacingOccurrences(of: "<", with: "")
        
        let name = holderNameParts[1].replacingOccurrences(of: " ", with: "")
        self.name = name.replacingOccurrences(of: "<", with: " ")
    }
}
