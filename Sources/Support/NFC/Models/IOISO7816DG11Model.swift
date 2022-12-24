//
//  IOISO7816DG11Model.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DG11Model: IONFCDataGroupModel {
    
    // MARK: - Properties
    
    public let fullName: String
    public let personalNumber: String
    public let dateOfBirth: String
    public let placeOfBirth: String
    public let address: String
    public let telephone: String
    public let profession: String
    public let title: String
    public let summary: String
    public let tdNumbers: String
    public let custody: String
    
    public var groupType: any IONFCDataGroup { IONFCISO7816DataGroup.dg11 }
    
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
        
        if header.prefix != 0x6B {
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
        
        var fullName = ""
        var personalNumber = ""
        var dateOfBirth = ""
        var placeOfBirth = ""
        var address = ""
        var telephone = ""
        var profession = ""
        var title = ""
        var summary = ""
        var tdNumbers = ""
        var custody = ""
        
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
            
            if tag.prefix == 0x5F && tag.length == 0x0E {
                fullName = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x10 {
                personalNumber = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x2B {
                dateOfBirth = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x11 {
                placeOfBirth = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x42 {
                address = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x12 {
                telephone = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x13 {
                profession = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x14 {
                title = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x15 {
                summary = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x17 {
                tdNumbers = currentTagContent ?? ""
            } else if tag.prefix == 0x5F && tag.length == 0x18 {
                custody = currentTagContent ?? ""
            }
            
            parsedData = parsedData.subdata(in: Data.Index(currentTagSize.size)..<parsedData.count)
        }
        
        self.fullName = fullName
        self.personalNumber = personalNumber
        self.dateOfBirth = dateOfBirth
        self.placeOfBirth = placeOfBirth
        self.address = address
        self.telephone = telephone
        self.profession = profession
        self.title = title
        self.summary = summary
        self.tdNumbers = tdNumbers
        self.custody = custody
    }
}
