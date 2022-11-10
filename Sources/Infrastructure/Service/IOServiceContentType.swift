//
//  IOServiceContentType.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation

public enum IOServiceContentType: String {
    
    case applicationJSON = "application/json"
    case applicationPDF = "application/pdf"
    case imagePNG = "image/png"
    case imageJPEG = "image/jpeg"
    case multipartFormData = "multipart/form-data"
    case textPlain = "text/plain"
    case textCSV = "text/csv"
}
