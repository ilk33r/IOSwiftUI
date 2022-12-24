//
//  IOISO7816DG2BiometryHeaderModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DG2BiometryHeaderModel {
    
    // MARK: - Properties
    
    public let headerVersion: String
    public let biometricType: String
    public let biometricSubType: String
    public let creationDate: String
    public let creationDate2: String
    public let validityPeriod: String
    public let creator: String
    public let formatOwner: String
    public let formatType: String
    
    // MARK: - Defs
    
    private struct TagHeader {
        
        let tag1: UInt8
        let tag2: UInt8
    }
    
    // MARK: - Initialization Methods
    
    public init(
        parsedData: inout Data,
        parsedDataSize: inout Int
    ) throws {
        let biometricInformationHeader = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader.tag1 != 0xA1 {
            throw IONFCParserError.invalidData
        }
        
        var headerVersion = ""
        var biometricType = ""
        var biometricSubType = ""
        var creationDate = ""
        var creationDate2 = ""
        var validityPeriod = ""
        var creator = ""
        var formatOwner = ""
        var formatType = ""
        var parsedSubData = Data()
        
        let biometricInformationHeader0 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader0.tag1 == 0x80 {
            headerVersion = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader0.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader0.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader1 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader1.tag1 == 0x81 {
            biometricType = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader1.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader1.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader2 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader2.tag1 == 0x82 {
            biometricSubType = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader2.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader2.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader3 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader3.tag1 == 0x83 {
            creationDate = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader3.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader3.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader4 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader4.tag1 == 0x84 {
            creationDate2 = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader4.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader4.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader5 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader5.tag1 == 0x85 {
            validityPeriod = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader5.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader5.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader6 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader6.tag1 == 0x86 {
            creator = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader6.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader6.tag2)..<parsedSubData.count)
        }
    
        let biometricInformationHeader7 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader7.tag1 == 0x87 {
            formatOwner = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader7.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader7.tag2)..<parsedSubData.count)
        }
        
        let biometricInformationHeader8 = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader8.tag1 == 0x88 {
            formatType = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader8.tag2)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader8.tag2)..<parsedSubData.count)
        }
        
        self.headerVersion = headerVersion
        self.biometricType = biometricType
        self.biometricSubType = biometricSubType
        self.creationDate = creationDate
        self.creationDate2 = creationDate2
        self.validityPeriod = validityPeriod
        self.creator = creator
        self.formatOwner = formatOwner
        self.formatType = formatType
    }
}
