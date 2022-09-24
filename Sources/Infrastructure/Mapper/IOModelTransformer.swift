//
//  IOModelTransformer.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

public protocol IOModelTransformer {
    
    func toJSONString<TType: Any>(data: TType) -> String?
    func fromJSONString<TType: Any>(string: String?) -> TType?
}
