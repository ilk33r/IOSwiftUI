//
//  IONFCDataGroup.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.12.2022.
//

import Foundation

public protocol IONFCDataGroup: RawRepresentable, Equatable, Hashable {
    
    func fieldMaps() -> [UInt8]
}
