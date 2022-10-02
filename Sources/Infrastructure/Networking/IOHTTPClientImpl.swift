//
//  IOHTTPClientImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import UIKit
import IOSwiftUICommon

final public class IOHTTPClientImpl: NSObject, IOHTTPClient, IOSingleton {
    
    public typealias InstanceType = IOHTTPClientImpl
    public static var _sharedInstance: IOHTTPClientImpl!
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfigurationImpl
    @IOInject private var httpLogger: IOHTTPLogger
    
    // MARK: - Publics
    
    public var defaultHTTPHeaders: [String: String]? { self._defaultHTTPHeaders }
    
    // MARK: - Privates
    
    private var _defaultHTTPHeaders: [String: String]?
    private var backgroundTasks: [Int: UIBackgroundTaskIdentifier]!
    private var baseURL: URL!
    
    private var timeoutInterval: TimeInterval!
    private var session: URLSession!
    
    // MARK: - Initialization Methods
    
    required public override init() {
        super.init()
        self.backgroundTasks = [:]
        self.baseURL = URL(string: self.configuration.configForType(type: .networkingApiUrl))!
        self.timeoutInterval = TimeInterval(self.configuration.configForType(type: .networkingApiTimeout))
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.timeoutIntervalForRequest = self.timeoutInterval
        self.session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        
        // Log call
        IOLogger.info("Http Client 2 configured. Base Url: \(self.baseURL.absoluteString)")
    }
    
    // MARK: - Http Client Methods
    
    @discardableResult
    public func request(
        type: IOHTTPRequestType,
        path: String,
        headers: [String: String]?,
        query: String?,
        body: Data?,
        handler: IOHTTPClient.Handler?
    ) -> IOCancellable {
        // Obtain task
        let task = self.request(
            method: type.rawValue,
            path: path,
            headers: headers,
            body: body,
            query: query,
            handler: handler
        )
        
        // Create a background task
        self.beginBackgroundTask(identifier: task.taskIdentifier)
        
        // Log call
        self.httpLogger.requestDidStart(task: task)
        
        // Create cancellable object
        let cancellable = IOHTTPRequestCancel(sessionTask: task)
        
        // Start task
        task.resume()
        
        // Return value
        return cancellable
    }
    
    public func setDefaultHTTPHeaders(headers: [String: String]?) {
        self._defaultHTTPHeaders = headers
    }
    
    // MARK: - Helper Methods
    
    private func httpHeaders(with headers: [String: String]?) -> [String: String] {
        var httpHeaders = [String: String]()
        
        if let defaultHeaders = self._defaultHTTPHeaders {
            for (key, value) in defaultHeaders {
                httpHeaders[key] = value
            }
        }
        
        if let requestHeaders = headers {
            for (key, value) in requestHeaders {
                httpHeaders[key] = value
            }
        }
        
        return httpHeaders
    }
    
    private func request(
        method: String,
        path: String,
        headers: [String: String]?,
        body: Data?,
        query: String?,
        handler: IOHTTPClient.Handler?
    ) -> URLSessionTask {
        // Prepare URL Request Object
        var requestURL: URL!
        if path.starts(with: "http") {
            requestURL = URL(string: path)!
        } else {
            requestURL = self.baseURL.appendingPathComponent(path)
        }
        if let urlQuery = query {
            requestURL = URL(string: String(format: "%@?%@", requestURL.absoluteString, urlQuery))!
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = method
        request.httpBody = body
        
        let httpHeaders = self.httpHeaders(with: headers)
        for (headerKey, headerValue) in httpHeaders {
            request.setValue(headerValue, forHTTPHeaderField: headerKey)
        }
        
        // Create a task
        var task: URLSessionTask?
        task = self.session.dataTask(with: request) { [weak self] data, response, error in
            // Obtain values
            let httpResponse = response as? HTTPURLResponse
            let responseHeaders = httpResponse?.allHeaderFields as? [String: String]
            let statusCode = httpResponse?.statusCode ?? 0
            let taskIdentifier = task?.taskIdentifier ?? 0
            
            // End background task
            self?.endBackgroundTask(identifier: taskIdentifier)
            
            // Log call
            self?.httpLogger.requestDidFinish(task: task, responseObject: data, error: error as NSError?)
            
            // Check error exist
            if let errorVal = error as NSError? {
                // Create an http error
                let httpError = IOHTTPError(error: errorVal)
                let httpResult = IOHTTPResult(
                    data: data,
                    error: httpError,
                    path: path,
                    responseHeaders: responseHeaders ?? [:],
                    statusCode: statusCode,
                    taskId: taskIdentifier
                )
                
                // Handle error
                DispatchQueue.main.async {
                    handler?(httpResult)
                }
                
                // Do nothing
                return
            }
            
            if 200 ... 299 ~= httpResponse?.statusCode ?? -1 {
                // Create an http result
                let httpResult = IOHTTPResult(
                    data: data,
                    error: nil,
                    path: path,
                    responseHeaders: responseHeaders ?? [:],
                    statusCode: statusCode,
                    taskId: taskIdentifier
                )
                
                // Handle success
                DispatchQueue.main.async {
                    handler?(httpResult)
                }
                
                // Do nothing
                return
            }
            
            // Create an http error
            let httpError = IOHTTPError(code: httpResponse?.statusCode ?? -1)
            let httpResult = IOHTTPResult(
                data: data,
                error: httpError,
                path: path,
                responseHeaders: responseHeaders ?? [:],
                statusCode: statusCode,
                taskId: taskIdentifier
            )
            
            // Handle error
            DispatchQueue.main.async {
                handler?(httpResult)
            }
        }
        
        return task!
    }
    
    // MARK: - Background Task
    
    private func beginBackgroundTask(identifier: Int) {
        let backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask(identifier: identifier)
        }
        
        self.backgroundTasks[identifier] = backgroundTaskIdentifier
    }
    
    private func endBackgroundTask(identifier: Int) {
        guard let backgroundTaskIdentifier = self.backgroundTasks[identifier] else { return }
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        self.backgroundTasks.removeValue(forKey: identifier)
    }
}

extension IOHTTPClientImpl: URLSessionDelegate {
    
}
