//
//  IOModelDecodableProperty.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

internal protocol IOModelDecodableProperty {
    
    typealias DecodeContainer = KeyedDecodingContainer<IOModelCodingKey>
    
    func decodeValue(from container: DecodeContainer, propertyName: String) throws
}
