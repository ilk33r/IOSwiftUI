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
    
    struct NetworkHistoryArchiveHeader {
        
        let methodTypeLength: Int64
        let pathLength: Int64
        let responseBodyLength: Int64
        let responseStatusCode: Int64
    }
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Serializer
    
    public func archive() -> Data {
        let archives = httpLogger.networkHistory.map { it in
            var data = Data()
            
            let methodTypeData = it.methodType.data(using: .utf8)!
            let methodTypeLength = Int64(methodTypeData.count)
            
            let pathData = it.path.data(using: .utf8)!
            let pathLength = Int64(pathData.count)
            
            let responseBodyData = it.responseBody.data(using: .utf8)!
            let responseBodyLength = Int64(responseBodyData.count)
            
            let responseStatusCode = Int64(it.responseStatusCode)
            
            var archiveMeta = NetworkHistoryArchiveHeader(
                methodTypeLength: methodTypeLength,
                pathLength: pathLength,
                responseBodyLength: responseBodyLength,
                responseStatusCode: responseStatusCode
            )
            
            let metadata = Data(bytes: &archiveMeta, count: MemoryLayout<NetworkHistoryArchiveHeader>.size)
            
            data.append(metadata)
            data.append(methodTypeData)
            data.append(pathData)
            data.append(responseBodyData)

            return data
        }
        
        var archivedData = Data()
        archivedData.append("#!IO".data(using: .utf8)!)
        archives.forEach { archivedData.append($0) }
        
        return archivedData
    }
}
