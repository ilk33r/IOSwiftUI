//
//  IONetworkHistorySerializer.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation

public struct IONetworkHistorySerializer {
    
    // MARK: - DI
    
    @IOInject private var httpLogger: IOHTTPLogger
    
    // MARK: - Defs
    
    public enum Errors: Error {
        case invalidArchive
    }

    struct ArchiveHeader {
        
        let methodTypeLength: Int
        let pathLength: Int
        let requestBodyLength: Int
        let responseHeadersLength: Int
        let responseBodyLength: Int
        let responseStatusCode: Int
    }
    
    // MARK: - Privates
    
    private let fileHeaderSignature = "#!IO"
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Serializer
    
    public func archive() -> Data {
        let archives = httpLogger.networkHistory.map { it in
            var data = Data()
            
            let methodTypeData = it.methodType.data(using: .utf8)!
            let methodTypeLength = methodTypeData.count
            
            let pathData = it.path.data(using: .utf8)!
            let pathLength = pathData.count
            
            let requestBodyData = it.requestBody.data(using: .utf8)!
            let requestBodyLength = requestBodyData.count
            
            let responseHeadersData = it.responseHeaders.data(using: .utf8)!
            let responseHeadersLength = responseHeadersData.count
            
            let responseBodyData = it.responseBody.data(using: .utf8)!
            let responseBodyLength = responseBodyData.count
            
            let responseStatusCode = it.responseStatusCode
            
            var archiveMeta = ArchiveHeader(
                methodTypeLength: methodTypeLength,
                pathLength: pathLength,
                requestBodyLength: requestBodyLength,
                responseHeadersLength: responseHeadersLength,
                responseBodyLength: responseBodyLength,
                responseStatusCode: responseStatusCode
            )
            
            let metadata = Data(bytes: &archiveMeta, count: MemoryLayout<ArchiveHeader>.size)
            
            data.append(metadata)
            data.append(methodTypeData)
            data.append(pathData)
            data.append(requestBodyData)
            data.append(responseHeadersData)
            data.append(responseBodyData)

            return data
        }
        
        var archivedData = Data()
        archivedData.append(fileHeaderSignature.data(using: .utf8)!)
        archives.forEach { archivedData.append($0) }
        
        return archivedData
    }
    
    public func unarchive(data: Data) throws -> [IOHTTPNetworkHistory] {
        let fileHeaderData = data.subdata(in: 0..<4)
        let fileHeaderString = String(data: fileHeaderData, encoding: .utf8)
        if fileHeaderString != fileHeaderSignature {
            throw Errors.invalidArchive
        }
        
        let headerSize = MemoryLayout<ArchiveHeader>.size
        
        var currentDataIndex = 4
        var resultData = [IOHTTPNetworkHistory]()
        
        while currentDataIndex < data.count {
            let headerData = data.subdata(in: currentDataIndex..<(headerSize + currentDataIndex))
            let header = headerData.withUnsafeBytes { buffer -> ArchiveHeader in
                buffer.load(as: ArchiveHeader.self)
            }
            currentDataIndex += headerSize
            
            let methodType = data.subdata(in: currentDataIndex..<(header.methodTypeLength + currentDataIndex))
            currentDataIndex += header.methodTypeLength
            
            let path = data.subdata(in: currentDataIndex..<(header.pathLength + currentDataIndex))
            currentDataIndex += header.pathLength
            
            let requestBody = data.subdata(in: currentDataIndex..<(header.requestBodyLength + currentDataIndex))
            currentDataIndex += header.requestBodyLength
            
            let responseHeaders = data.subdata(in: currentDataIndex..<(header.responseHeadersLength + currentDataIndex))
            currentDataIndex += header.responseHeadersLength
            
            let responseBody = data.subdata(in: currentDataIndex..<(header.responseBodyLength + currentDataIndex))
            currentDataIndex += header.responseBodyLength
            
            let responseStatusCode = header.responseStatusCode
            resultData.append(IOHTTPNetworkHistory(
                icon: "",
                methodType: String(data: methodType, encoding: .utf8) ?? "",
                path: String(data: path, encoding: .utf8) ?? "",
                requestHeaders: "",
                requestBody: String(data: requestBody, encoding: .utf8) ?? "",
                responseHeaders: String(data: responseHeaders, encoding: .utf8) ?? "",
                responseBody: String(data: responseBody, encoding: .utf8) ?? "",
                responseStatusCode: responseStatusCode
            ))
        }
        
        return resultData
    }
}
