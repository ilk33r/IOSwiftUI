//
//  ArrayExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation

public extension Array where Element == UInt8 {
    
    var data: Data {
        return Data(self)
    }
}
