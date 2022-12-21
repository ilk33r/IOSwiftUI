//
//  IONFCBinary8Model.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.12.2022.
//

import Foundation

struct IONFCBinary8Model {
    
    let prefix: UInt8
    let length: UInt8
    
    init(prefix: UInt8, length: UInt8) {
        self.prefix = prefix
        self.length = length
    }
}
