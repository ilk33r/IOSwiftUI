//
//  IOBinaryMapper.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.12.2022.
//

import Foundation

public struct IOBinaryMapper {
    
    // BitwiseCopyable
    public static func toBinary<THeader>(header: THeader, content: Data) -> Data {
        let mutableHeader = header
        let serializedHeader = withUnsafePointer(to: mutableHeader) {
            Data(bytes: $0, count: MemoryLayout<THeader>.size)
        }
        return serializedHeader + content
    }
    
    public static func fromBinary<THeader>(
        header: THeader.Type,
        binaryData: Data,
        content: inout Data,
        size: inout Int
    ) -> THeader {
        let headerSize = MemoryLayout<THeader>.size
        let headerData = binaryData.subdata(in: 0..<headerSize)
        let header = headerData.withUnsafeBytes { buffer -> THeader in
            buffer.load(as: THeader.self)
        }
        
        content = binaryData.subdata(in: headerSize..<binaryData.count)
        size = headerSize
        return header
    }
}
