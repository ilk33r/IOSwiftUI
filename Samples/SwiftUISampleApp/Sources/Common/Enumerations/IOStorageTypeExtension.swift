//
//  IOStorageTypeExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.09.2022.
//

import Foundation
import IOSwiftUICommon

public extension IOStorageType {
    
    static let aesIV = IOStorageType(rawValue: "aesIV")
    static let aesKey = IOStorageType(rawValue: "aesKey")
    static let userToken = IOStorageType(rawValue: "userToken")
}
