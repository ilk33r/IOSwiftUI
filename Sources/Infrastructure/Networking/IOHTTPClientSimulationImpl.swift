//
//  IOHTTPClientSimulationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOHTTPClientSimulationImpl: IOHTTPClient, IOSingleton {
    
    public typealias InstanceType = IOHTTPClientSimulationImpl
    public static var _sharedInstance: IOHTTPClientSimulationImpl!
    
    // MARK: - DI
    
    @IOInject private var appleSettings: IOAppleSetting
    @IOInject private var configuration: IOConfiguration
    @IOInject private var thread: IOThread
    
    // MARK: - Publics
    
    public var defaultHTTPHeaders: [String: String]? { [:] }
    
    // MARK: - Privates
    
    private var baseURL: URL!
    private var networkHistory: [IOHTTPNetworkHistory]
    private var responseTime: Int!
    
    // MARK: - Initialization Methods
    
    public init() {
        self.networkHistory = []
        self.baseURL = URL(string: self.configuration.configForType(type: .networkingApiUrl))!
        self.responseTime = Int(self.appleSettings.float(for: .debugSimulationHTTPResponseTime) * 1000)
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
        // Prepare URL Request Object
        var requestURL: URL!
        if path.starts(with: "http") {
            requestURL = URL(string: path)!
        } else {
            requestURL = baseURL.appendingPathComponent(path)
        }
        if let urlQuery = query {
            requestURL = URL(string: String(format: "%@?%@", requestURL.absoluteString, urlQuery))!
        }
        
        return self.thread.runOnBackgroundThread(afterMilliSecond: self.responseTime) { [weak self] in
            
            guard
                let networkHistories = self?.networkHistory.filter({ $0.path == requestURL.absoluteString }),
                !networkHistories.isEmpty else {
                let error = NSError(domain: "com.ilkerozcan.ioswiftui.httpsimulation", code: NSURLErrorTimedOut)
                let result = IOHTTPResult(
                    data: nil,
                    error: IOHTTPError(error: error),
                    path: path,
                    responseHeaders: [:],
                    statusCode: -1,
                    taskId: 0
                )
                self?.thread.runOnMainThread {
                    handler?(result)
                }
                return
            }
            
            if networkHistories.count == 1 {
                self?.sendNetworkResult(networkHistories.first!, path: path, handler: handler)
            } else if
                let requestBody = body,
                let requestBodyString = String(data: requestBody, encoding: .utf8)
            {
                let networkHistoriesForRequest = networkHistories.filter({ $0.requestBody == requestBodyString })
                if !networkHistoriesForRequest.isEmpty {
                    self?.sendNetworkResult(networkHistoriesForRequest.first!, path: path, handler: handler)
                } else {
                    self?.sendNetworkResult(networkHistories.first!, path: path, handler: handler)
                }
            } else {
                self?.sendNetworkResult(networkHistories.first!, path: path, handler: handler)
            }
        }
    }
    
    public func setDefaultHTTPHeaders(headers: [String: String]?) {
        
    }
    
    // MARK: - Archiver Methods
    
    public func loadArchive(networkHistory: [IOHTTPNetworkHistory]) {
        self.networkHistory = networkHistory
    }
    
    // MARK: - Helper Methods
    
    private func sendNetworkResult(_ result: IOHTTPNetworkHistory, path: String, handler: Handler?) {
        let responseHeaders: [String: String]
        
        if
            let headersData = result.responseHeaders.data(using: .utf8),
            let responseHeadersJSON = try? JSONSerialization.jsonObject(with: headersData) as? [String: String] {
            responseHeaders = responseHeadersJSON
        } else {
            responseHeaders = [:]
        }
        
        let httpResult = IOHTTPResult(
            data: result.responseBody.data(using: .utf8),
            error: nil,
            path: path,
            responseHeaders: responseHeaders,
            statusCode: result.responseStatusCode,
            taskId: 0
        )
        
        self.thread.runOnMainThread {
            handler?(httpResult)
        }
    }
}
