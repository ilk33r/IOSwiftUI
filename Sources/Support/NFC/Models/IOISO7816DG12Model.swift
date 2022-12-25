//
//  IOISO7816DG12Model.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DG12Model: IONFCDataGroupModel {
    
    // MARK: - Properties
    
    public let issuingAuthority: String
    public let dateOfIssue: String
    public let observations: String
    public let requirements: String
    public let dateAndTime: String
    public let serialNumber: String
    
    public var groupType: any IONFCDataGroup { IONFCISO7816DataGroup.dg12 }
    
    // MARK: - Initialization Methods
    
    public init(data: Data) throws {
        var parsedData = data
        var parsedDataSize = 0
        
        let header = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if header.prefix != 0x6C {
            throw IONFCParserError.invalidData
        }
        
        if header.length >= 0x82 {
            parsedData = parsedData.subdata(in: 2..<parsedData.count)
        }
        
        let tagList = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if tagList.prefix != 0x5C {
            throw IONFCParserError.invalidData
        }
        
        var availableTags = [IONFCBinary8Model]()
        for _ in 0..<(tagList.length / 2) {
            let tag = IOBinaryMapper.fromBinary(
                header: IONFCBinary8Model.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            availableTags.append(tag)
        }
        
        var issuingAuthority = ""
        var dateOfIssue = ""
        var observations = ""
        var requirements = ""
        var dateAndTime = ""
        var serialNumber = ""
        
        for tag in availableTags {
            let currentTag = IOBinaryMapper.fromBinary(
                header: IONFCBinary8Model.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            if tag.prefix != currentTag.prefix || tag.length != currentTag.length {
                throw IONFCParserError.invalidData
            }
            
            let currentTagSize = IOBinaryMapper.fromBinary(
                header: IONFCBinaryDataSizeModel.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            let currentTagContent = String(data: parsedData.subdata(in: 0..<Data.Index(currentTagSize.size)), encoding: .utf8)
            
            if tag.prefix == 0x5F && tag.length == 0x19 {
                issuingAuthority = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x26 {
                dateOfIssue = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x1B {
                observations = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x1C {
                requirements = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x55 {
                dateAndTime = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x56 {
                serialNumber = currentTagContent ?? ""
            }
            
            parsedData = parsedData.subdata(in: Data.Index(currentTagSize.size)..<parsedData.count)
        }
        
        self.issuingAuthority = issuingAuthority
        self.dateOfIssue = dateOfIssue
        self.observations = observations
        self.requirements = requirements
        self.dateAndTime = dateAndTime
        self.serialNumber = serialNumber
    }
}
