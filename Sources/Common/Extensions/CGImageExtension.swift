//
//  CGImageExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.03.2023.
//

import Foundation
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

public extension CGImage {
    
    static func create(fromRawData rawData: Data) -> CGImage? {
        return Self.create(fromData: rawData, type: .bmp)
    }
    
    static func create(fromPngData pngData: Data) -> CGImage? {
        return Self.create(fromData: pngData, type: .png)
    }
    
    static func create(fromJpegData jpegData: Data) -> CGImage? {
        return Self.create(fromData: jpegData, type: .jpeg)
    }
    
    static func create(fromData data: Data, type: UTType)  -> CGImage? {
        let cfData = data as CFData
        let attributes = [
            kCGImageSourceTypeIdentifierHint: type.identifier
        ] as NSDictionary
        
        if let source = CGImageSourceCreateWithData(cfData, attributes) {
            return CGImageSourceCreateImageAtIndex(source, 0, nil)
        }
        
        return nil
    }
    
    func rawData() -> Data? {
        guard
            let mutableData = CFDataCreateMutable(nil, 0),
            let destination = CGImageDestinationCreateWithData(mutableData, UTType.bmp.identifier as CFString, 1, nil) else { return nil }
        CGImageDestinationAddImage(destination, self, nil)
        guard CGImageDestinationFinalize(destination) else { return nil }
        return mutableData as Data
    }
}
