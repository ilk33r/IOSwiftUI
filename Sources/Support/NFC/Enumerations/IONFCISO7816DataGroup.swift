//
//  IONFCISO7816DataGroup.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation

public struct IONFCISO7816DataGroup: IONFCDataGroup {

    public typealias RawValue = UInt8

    public static let com = Self(rawValue: 0x60)
    public static let dg1 = Self(rawValue: 0x61)
    public static let dg2 = Self(rawValue: 0x75)
    public static let dg3 = Self(rawValue: 0x63)
    public static let dg4 = Self(rawValue: 0x76)
    public static let dg5 = Self(rawValue: 0x65)
    public static let dg6 = Self(rawValue: 0x66)
    public static let dg7 = Self(rawValue: 0x67)
    public static let dg8 = Self(rawValue: 0x68)
    public static let dg9 = Self(rawValue: 0x69)
    public static let dg10 = Self(rawValue: 0x6A)
    public static let dg11 = Self(rawValue: 0x6B)
    public static let dg12 = Self(rawValue: 0x6C)
    public static let dg13 = Self(rawValue: 0x6D)
    public static let dg14 = Self(rawValue: 0x6E)
    public static let dg15 = Self(rawValue: 0x6F)
    public static let dg16 = Self(rawValue: 0x70)
    public static let sod = Self(rawValue: 0x77)
    public static let unknown = Self(rawValue: 0x00)
    
    public var rawValue: UInt8
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
    
    public func fieldMaps() -> [UInt8] {
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
            
        default:
            return [0x01, 0x1E]
        }
    }
}
