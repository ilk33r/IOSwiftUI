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
}
