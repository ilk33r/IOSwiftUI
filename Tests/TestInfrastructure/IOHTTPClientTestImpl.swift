//
//  IOHTTPClientTestImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Combine
import Foundation
@testable import IOSwiftUICommon
@testable import IOSwiftUIInfrastructure

private extension IOPublisherType {
    static let httpRequestStatusType = IOPublisherType(rawValue: "httpRequestStatus")
}

final public class IOHTTPClientTestImpl: IOHTTPClient, IOSingleton {
    
    public typealias InstanceType = IOHTTPClientTestImpl
    public static var _sharedInstance: IOHTTPClientTestImpl!
    
    // MARK: - DI
    
    @IOInject private var eventProcess: IOEventProcess
    @IOInject private var thread: IOThread
    
    // MARK: - Publics
    
    public var defaultHTTPHeaders: [String: String]? { [:] }
    public var httpRequestStatus: AnyPublisher<Bool?, Never> {
        self.eventProcess.bool(forType: .httpRequestStatusType)
    }
    
    // MARK: - Privates
    
    private var headerDatas: [String: Data]
    private var responseDatas: [String: Data]
    private var responseStatusCodes: [String: Int]
    private var responseTime: Int!
    
    // MARK: - Initialization Methods
    
    public init() {
        self.headerDatas = [:]
        self.responseDatas = [:]
        self.responseStatusCodes = [:]
        self.responseTime = 250
    }
    
    // MARK: - Http Client Methods
    
    public func setResponseHeaders(for path: String, fileName: String, bundle: Bundle) {
        self.headerDatas[path] = self.jsonData(from: fileName, bundle: bundle)
    }
    
    public func setResponse(for path: String, fileName: String, bundle: Bundle) {
        self.responseDatas[path] = self.jsonData(from: fileName, bundle: bundle)
    }
    
    public func setResponseStatusCode(for path: String, statusCode: Int) {
        self.responseStatusCodes[path] = statusCode
    }
    
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
        // Prepare URL Request Object
        var requestURL = path
        if let urlQuery = query {
            requestURL = requestURL + "?" + urlQuery
        }
        
        return self.thread.runOnBackgroundThread(afterMilliSecond: self.responseTime) { [weak self] in
            self?.sendNetworkResult(path: requestURL, handler: handler)
        }
    }
    
    public func setDefaultHTTPHeaders(headers: [String: String]?) {
        
    }
    
    // MARK: - Helper Methods
    
    private func jsonData(from file: String, bundle: Bundle) -> Data {
        do {
            if let fileURL = bundle.url(forResource: file, withExtension: "json") {
                return try Data(contentsOf: fileURL)
            }
        } catch {
            fatalError("Could not found \(file).json")
        }
        
        fatalError("Could not found \(file).json")
    }
    
    private func sendNetworkResult(path: String, handler: Handler?) {
        let responseHeaders: [String: String]
        
        if
            let headersData = self.headerDatas[path],
            let responseHeadersJSON = try? JSONSerialization.jsonObject(with: headersData) as? [String: String] {
            responseHeaders = responseHeadersJSON
        } else {
            responseHeaders = [:]
        }
        
        let httpResult = IOHTTPResult(
            data: self.responseDatas[path],
            error: nil,
            path: path,
            responseHeaders: responseHeaders,
            statusCode: self.responseStatusCodes[path] ?? 0,
            taskId: 0
        )
        
        self.thread.runOnMainThread { [weak self] in
            handler?(httpResult)
            self?.eventProcess.set(bool: true, forType: .httpRequestStatusType)
        }
    }
}
