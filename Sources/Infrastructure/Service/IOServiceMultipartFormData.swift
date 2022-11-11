//
//  IOServiceMultipartFormData.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation

public struct IOServiceMultipartFormData {
    
    public let formName: String
    public let contentType: IOServiceContentType
    public let content: Data
    public var fileName: String?
    
    public init(formName: String, contentType: IOServiceContentType, content: Data, fileName: String?) {
        self.formName = formName
        self.contentType = contentType
        self.content = content
        self.fileName = fileName
    }
}
