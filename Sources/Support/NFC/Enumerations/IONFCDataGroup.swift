//
//  IONFCDataGroup.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation

public enum IONFCDataGroup: Int {
    
    case com = 0x60
    case dg1 = 0x61
    case dg2 = 0x75
    case dg3 = 0x63
    case dg4 = 0x76
    case dg5 = 0x65
    case dg6 = 0x66
    case dg7 = 0x67
    case dg8 = 0x68
    case dg9 = 0x69
    case dg10 = 0x6A
    case dg11 = 0x6B
    case dg12 = 0x6C
    case dg13 = 0x6D
    case dg14 = 0x6E
    case dg15 = 0x6F
    case dg16 = 0x70
    case sod = 0x77
    case unknown = 0x00
    
    func fieldMaps() -> [UInt8] {
        switch self {
        case .com:
            return [0x01, 0x1E]
            
        case .dg1:
            return [0x01, 0x01]
            
        case .dg2:
            return [0x01, 0x02]
            
        case .dg3:
            return [0x01, 0x03]
            
        case .dg4:
            return [0x01, 0x04]
            
        case .dg5:
            return [0x01, 0x05]
            
        case .dg6:
            return [0x01, 0x06]
            
        case .dg7:
            return [0x01, 0x07]
            
        case .dg8:
            return [0x01, 0x08]
            
        case .dg9:
            return [0x01, 0x09]
            
        case .dg10:
            return [0x01, 0x0A]
            
        case .dg11:
            return [0x01, 0x0B]
            
        case .dg12:
            return [0x01, 0x0C]
            
        case .dg13:
            return [0x01, 0x0D]
            
        case .dg14:
            return [0x01, 0x0E]
            
        case .dg15:
            return [0x01, 0x0F]
            
        case .dg16:
            return [0x01, 0x10]
            
        case .sod:
            return [0x01, 0x1D]
            
        case .unknown:
            return [0x01, 0x1E]
        }
    }
}
