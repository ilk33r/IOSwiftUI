//
//  IOServiceProviderError.swift
//  
//
//  Created by Adnan ilker Ozcan on 14.01.2023.
//

import Foundation

public enum IOServiceProviderError<TModel: Codable>: Error {
    
    case error(message: String?, type: IOHTTPError.ErrorType, response: TModel?)
}
