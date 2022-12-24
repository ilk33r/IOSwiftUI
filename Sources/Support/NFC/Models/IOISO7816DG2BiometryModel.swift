//
//  IOISO7816DG2BiometryModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import UIKit

public struct IOISO7816DG2BiometryModel {
    
    // MARK: - Properties
    
    public let header: IOISO7816DG2BiometryHeaderModel
    public let image: UIImage?
    
    // MARK: - Defs
    
    private struct TagHeader {
        
        let tag1: UInt8
        let tag2: UInt8
    }
    
    private struct TagSizePrefix {
        
        let sizeLength: UInt8
    }
    
    private struct TagDataSize {
        
        let sizeLength: UInt16
    }
    
    // MARK: - Initialization Methods
    
    public init(
        parsedData: inout Data,
        parsedDataSize: inout Int
    ) throws {
        self.header = try IOISO7816DG2BiometryHeaderModel(parsedData: &parsedData, parsedDataSize: &parsedDataSize)
        
        let biometricDataHeader = IOBinaryMapper.fromBinary(
            header: TagHeader.self,
            binaryData: parsedData,
            content: &parsedData,
            size: &parsedDataSize
        )
        
        if
            (biometricDataHeader.tag1 == 0x5F && biometricDataHeader.tag2 == 0x2E) ||
                (biometricDataHeader.tag1 == 0x7F && biometricDataHeader.tag2 == 0x2E) {
            let biometricDataSizePrefix = IOBinaryMapper.fromBinary(
                header: TagSizePrefix.self,
                binaryData: parsedData,
                content: &parsedData,
                size: &parsedDataSize
            )
            
            var biometricImageData: Data
            if biometricDataSizePrefix.sizeLength >= 0x82 {
                let biometricDataSize = IOBinaryMapper.fromBinary(
                    header: TagDataSize.self,
                    binaryData: parsedData,
                    content: &parsedData,
                    size: &parsedDataSize
                )
                
                biometricImageData = parsedData.subdata(in: 0..<Data.Index(biometricDataSize.sizeLength.bigEndian))
            } else {
                biometricImageData = parsedData.subdata(in: 0..<Data.Index(biometricDataSizePrefix.sizeLength))
            }
            
            if biometricImageData[0] != 0x46 && biometricImageData[1] != 0x41 && biometricImageData[2] != 0x43 && biometricImageData[3] != 0x00 {
                throw IONFCParserError.invalidData
            }
            
            biometricImageData = biometricImageData.subdata(in: 46..<biometricImageData.count)
            self.image = UIImage(data: biometricImageData)
        } else {
            self.image = nil
        }
    }
}
