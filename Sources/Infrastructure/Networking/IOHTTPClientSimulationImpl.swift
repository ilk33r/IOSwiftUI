//
//  IOHTTPClientSimulationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOHTTPClientSimulationImpl: IOHTTPClient, IOSingleton {
    
    public typealias InstanceType = IOHTTPClientSimulationImpl
    public static var _sharedInstance: IOHTTPClientSimulationImpl!
    
    // MARK: - DI
    
    @IOInject private var fileCache: IOFileCacheImpl
    
    // MARK: - Publics
    
    public var defaultHTTPHeaders: [String: String]? { [:] }
    
    // MARK: - Privates
    
    private let networkHistoryFileName = "IO_RecordedNetworkHistory"
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Http Client Methods
    
    @discardableResult
    public func request(
        type: IOHTTPRequestType,
        path: String,
        contentType: String,
        headers: [String: String]?,
        query: String?,
        body: Data?,
        handler: Handler?
    ) -> IOCancellable {
        return IOHTTPRequestCancel(sessionTask: nil)
    }
    
    public func setDefaultHTTPHeaders(headers: [String: String]?) {
        
    }
    
    // MARK: - Helper Methods
    
    public func saveArchive(_ data: Data) throws {
        try fileCache.removeFile(fromCache: networkHistoryFileName)
        try fileCache.storeFile(toCache: networkHistoryFileName, fileData: data)
    }
    
    public func loadArchive() throws {
        let archiveData = try fileCache.getFile(fromCache: networkHistoryFileName)
        
        let networkSerializer = IONetworkHistorySerializer()
        let networkHistory = try networkSerializer.unarchive(data: archiveData)
    }
}
