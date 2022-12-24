//
//  IOISO7816DG2Model.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DG2Model {
    
    // MARK: - Properties
    
    public let numberOfBiometricInformation: Int
    public let biometricDatas: [IOISO7816DG2BiometryModel]
    
    // MARK: - Defs
    
    private struct TagHeader {
        
        let tag1: UInt8
        let tag2: UInt8
    }
    
    private struct TagSizePrefix {
        
        let sizeLength: UInt8
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
        
        if header.tag1 != 0x75 {
            throw IONFCParserError.invalidData
        }
        
        if header.tag2 >= 0x82 {
            parsedData = parsedData.subdata(in: 2..<parsedData.count)
        }
        
        let templateHeader = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if templateHeader.tag1 != 0x7F && templateHeader.tag1 != 0x61 {
            throw IONFCParserError.invalidData
        }
        
        let templateHeaderSize = IOBinaryMapper.fromBinary(
            header: TagSizePrefix.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if templateHeaderSize.sizeLength >= 0x82 {
            parsedData = parsedData.subdata(in: 2..<parsedData.count)
        }
        
        let biometricInformation = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if biometricInformation.tag1 != 0x02 {
            throw IONFCParserError.invalidData
        }
        
        let biometricInformationSize = IOBinaryMapper.fromBinary(
            header: TagSizePrefix.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        self.numberOfBiometricInformation = Int(biometricInformationSize.sizeLength)
        
        var biometricDatas = [IOISO7816DG2BiometryModel]()
        for _ in 0..<biometricInformationSize.sizeLength {
            let biometricInformationTemplate = IOBinaryMapper.fromBinary(
                header: TagHeader.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            if biometricInformationTemplate.tag1 != 0x7F && biometricInformationTemplate.tag1 != 0x60 {
                throw IONFCParserError.invalidData
            }
            
            let biometricInformationTemplateSize = IOBinaryMapper.fromBinary(
                header: TagSizePrefix.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            if biometricInformationTemplateSize.sizeLength >= 0x82 {
                parsedData = parsedData.subdata(in: 2..<parsedData.count)
            }
            
            let biometryModel = try IOISO7816DG2BiometryModel(parsedData: &parsedData, parsedDataSize: &parsedDataSize)
            biometricDatas.append(biometryModel)
        }
        
        self.biometricDatas = biometricDatas
    }
}
