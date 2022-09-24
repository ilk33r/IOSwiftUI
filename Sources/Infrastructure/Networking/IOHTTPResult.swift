//
//  IOHTTPResult.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

public struct IOHTTPResult {
    
    public let data: Data?
    public let error: IOHTTPError?
    public let path: String
    public let responseHeaders: [String: String]
    public let statusCode: Int
    public let taskId: Int
}
