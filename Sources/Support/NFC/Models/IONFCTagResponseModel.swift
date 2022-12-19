//
//  IONFCTagResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation

struct IONFCTagResponseModel {
    
    let sw1: UInt8
    let sw2: UInt8
    let data: Data
    
    init(
        sw1: UInt8,
        sw2: UInt8,
        data: Data
    ) {
        self.sw1 = sw1
        self.sw2 = sw2
        self.data = data
    }
}
