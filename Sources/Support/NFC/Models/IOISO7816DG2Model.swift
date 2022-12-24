//
//  IOISO7816DG2Model.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOISO7816DG2Model: IONFCDataGroupModel {
    
    // MARK: - Properties
    
    public let numberOfBiometricInformation: Int
    public let biometricDatas: [IOISO7816DG2BiometryModel]
    
    public var groupType: any IONFCDataGroup { IONFCISO7816DataGroup.dg2 }
    
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
        
        if header.prefix != 0x75 {
            throw IONFCParserError.invalidData
        }
        
        if header.length >= 0x82 {
            parsedData = parsedData.subdata(in: 2..<parsedData.count)
        }
        
        let templateHeader = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if templateHeader.prefix != 0x7F && templateHeader.length != 0x61 {
            throw IONFCParserError.invalidData
        }
        
        let templateHeaderSize = IOBinaryMapper.fromBinary(
            header: IONFCBinaryDataSizeModel.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if templateHeaderSize.size >= 0x82 {
            parsedData = parsedData.subdata(in: 2..<parsedData.count)
        }
        
        let biometricInformation = IOBinaryMapper.fromBinary(
            header: IONFCBinary8Model.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if biometricInformation.prefix != 0x02 {
            throw IONFCParserError.invalidData
        }
        
        let biometricInformationSize = IOBinaryMapper.fromBinary(
            header: IONFCBinaryDataSizeModel.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        self.numberOfBiometricInformation = Int(biometricInformationSize.size)
        
        var biometricDatas = [IOISO7816DG2BiometryModel]()
        for _ in 0..<biometricInformationSize.size {
            let biometricInformationTemplate = IOBinaryMapper.fromBinary(
                header: IONFCBinary8Model.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            if biometricInformationTemplate.prefix != 0x7F && biometricInformationTemplate.length != 0x60 {
                throw IONFCParserError.invalidData
            }
            
            let biometricInformationTemplateSize = IOBinaryMapper.fromBinary(
                header: IONFCBinaryDataSizeModel.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            if biometricInformationTemplateSize.size >= 0x82 {
                parsedData = parsedData.subdata(in: 2..<parsedData.count)
            }
            
            let biometryModel = try IOISO7816DG2BiometryModel(parsedData: &parsedData, parsedDataSize: &parsedDataSize)
            biometricDatas.append(biometryModel)
        }
        
        self.biometricDatas = biometricDatas
    }
}
