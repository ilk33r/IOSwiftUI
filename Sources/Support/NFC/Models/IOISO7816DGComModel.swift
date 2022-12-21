//
//  IOISO7816DGComModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DGComModel {
    
    // MARK: - Properties
    
    public let version: String
    public let unicodeVersion: String
    public let dataGroups: [IONFCISO7816DataGroup]
    
    // MARK: - Defs
    
    private struct TagHeader {
        
        let prefix: UInt8
        let length: UInt8
    }
    
    private struct TagVersion {
        
        let tag1: UInt8
        let tag2: UInt8
        let length: UInt8
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
        
        if header.prefix != 0x60 {
            throw IONFCParserError.invalidData
        }
        
        let version1 = IOBinaryMapper.fromBinary(
            header: TagVersion.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if version1.tag1 == 0x5F && version1.tag2 == 0x01 {
            let versionContent = parsedData.subdata(in: 0..<Data.Index(version1.length))
            self.version = String(data: versionContent, encoding: .utf8) ?? ""
            parsedData = parsedData.subdata(in: Data.Index(version1.length)..<parsedData.count)
        } else {
            throw IONFCParserError.invalidData
        }
        
        let version2 = IOBinaryMapper.fromBinary(
            header: TagVersion.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if version2.tag1 == 0x5F && version2.tag2 == 0x36 {
            let versionContent = parsedData.subdata(in: 0..<Data.Index(version2.length))
            self.unicodeVersion = String(data: versionContent, encoding: .utf8) ?? ""
            parsedData = parsedData.subdata(in: Data.Index(version2.length)..<parsedData.count)
        } else {
            throw IONFCParserError.invalidData
        }
        
        let dataGroups = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if dataGroups.prefix == 0x5C {
            let bytes = parsedData.bytes
            var availableDataGroups = [IONFCISO7816DataGroup]()
            for i in 0..<dataGroups.length {
                availableDataGroups.append(IONFCISO7816DataGroup(rawValue: bytes[Int(i)]))
            }
            
            self.dataGroups = availableDataGroups
        } else {
            throw IONFCParserError.invalidData
        }
    }
}
