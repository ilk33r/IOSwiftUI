//
//  IOModelEncodableProperty.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

internal protocol IOModelEncodableProperty {
    
    typealias EncodeContainer = KeyedEncodingContainer<IOModelCodingKey>
    
    func encodeValue(from container: inout EncodeContainer, propertyName: String) throws
}
