//
//  IOServiceContentType.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation

public struct IOServiceContentType: RawRepresentable, Equatable, Hashable {
    
    public typealias RawValue = String
    
    public static let applicationJSON = Self(rawValue: "application/json")
    public static let applicationPDF = Self(rawValue: "application/pdf")
    public static let imagePNG = Self(rawValue: "image/png")
    public static let imageJPEG = Self(rawValue: "image/jpeg")
    public static let textPlain = Self(rawValue: "text/plain")
    public static let textCSV = Self(rawValue: "text/csv")
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
    
    public static func multipartFormData(boundary: String) -> IOServiceContentType {
        // boundary = UUID().uuidString
        Self(rawValue: "multipart/form-data; boundary=\(boundary)")
    }
}
