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
    
    // MARK: - Initialization Methods
    
    public init(
        parsedData: inout Data,
        parsedDataSize: inout Int
    ) throws {
        let biometricInformationHeader = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader.prefix != 0xA1 {
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
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader0.prefix == 0x80 {
            headerVersion = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader0.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader0.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader1 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader1.prefix == 0x81 {
            biometricType = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader1.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader1.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader2 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader2.prefix == 0x82 {
            biometricSubType = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader2.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader2.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader3 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader3.prefix == 0x83 {
            creationDate = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader3.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader3.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader4 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader4.prefix == 0x84 {
            creationDate2 = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader4.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader4.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader5 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader5.prefix == 0x85 {
            validityPeriod = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader5.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader5.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader6 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader6.prefix == 0x86 {
            creator = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader6.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader6.length)..<parsedSubData.count)
        }
    
        let biometricInformationHeader7 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader7.prefix == 0x87 {
            formatOwner = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader7.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader7.length)..<parsedSubData.count)
        }
        
        let biometricInformationHeader8 = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedSubData,
            size: &parsedDataSize
        )
        
        if biometricInformationHeader8.prefix == 0x88 {
            formatType = parsedSubData.subdata(in: 0..<Data.Index(biometricInformationHeader8.length)).toHexString()
            parsedData = parsedSubData.subdata(in: Data.Index(biometricInformationHeader8.length)..<parsedSubData.count)
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
