//
//  IOServiceContentType.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation

public struct IOServiceContentType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let applicationJSON = IOServiceContentType(rawValue: "application/json")
    public static let applicationPDF = IOServiceContentType(rawValue: "application/pdf")
    public static let imagePNG = IOServiceContentType(rawValue: "image/png")
    public static let imageJPEG = IOServiceContentType(rawValue: "image/jpeg")
    public static let textPlain = IOServiceContentType(rawValue: "text/plain")
    public static let textCSV = IOServiceContentType(rawValue: "text/csv")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
    
    public static func multipartFormData(boundary: String) -> IOServiceContentType {
        // boundary = UUID().uuidString
        return IOServiceContentType(rawValue: "multipart/form-data; boundary=\(boundary)")
    }
}
