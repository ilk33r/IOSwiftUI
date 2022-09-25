//
//  IOServiceResult.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation

public enum IOServiceResult<TModel: Codable> {
    
    case success(response: TModel)
    case error(message: String?, type: IOHTTPError.ErrorType, response: TModel?)
}
