//
//  IOHTTPNetworkHistory.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation

public struct IOHTTPNetworkHistory {
    
    public let icon: String
    public let methodType: String
    public let path: String
    public let requestHeaders: String
    public let requestBody: String
    public let responseHeaders: String
    public let responseBody: String
    public let responseStatusCode: Int
    
    public init(
        icon: String,
        methodType: String,
        path: String,
        requestHeaders: String,
        requestBody: String,
        responseHeaders: String,
        responseBody: String,
        responseStatusCode: Int
    ) {
        self.icon = icon
        self.methodType = methodType
        self.path = path
        self.requestHeaders = requestHeaders
        self.requestBody = requestBody
        self.responseHeaders = responseHeaders
        self.responseBody = responseBody
        self.responseStatusCode = responseStatusCode
    }
}
