//
//  IOHTTPClientImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import UIKit
import IOSwiftUICommon

public struct IOHTTPClientImpl: IOHTTPClient, IOSingleton {
    
    public typealias InstanceType = IOHTTPClientImpl
    public static var _sharedInstance: IOHTTPClientImpl!
    
    // MARK: - DI
    
    @IOInject private var appState: IOAppState
    @IOInject private var configuration: IOConfiguration
    @IOInject private var httpLogger: IOHTTPLogger
    @IOInject private var thread: IOThread
    
    // MARK: - Publics
    
    public var defaultHTTPHeaders: [String: String]? { appState.object(forType: .httpClientDefaultHeaders) as? [String: String] }
    
    // MARK: - Privates
    
    private var backgroundTasks: [Int: UIBackgroundTaskIdentifier]? { appState.object(forType: .httpClientBackgroundTasks) as? [Int: UIBackgroundTaskIdentifier] }
    
    private var baseURL: URL!
    private var timeoutInterval: TimeInterval!
    private var session: URLSession!
    
    // MARK: - Initialization Methods
    
    public init() {
        self.appState.set(object: [Int: UIBackgroundTaskIdentifier](), forType: .httpClientBackgroundTasks)
        self.baseURL = URL(string: self.configuration.configForType(type: .networkingApiUrl))!
        self.timeoutInterval = TimeInterval(self.configuration.configForType(type: .networkingApiTimeout)) ?? 0
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.timeoutIntervalForRequest = self.timeoutInterval
        self.session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
        
        // Log call
        IOLogger.info("Http Client 2 configured. Base Url: \(self.baseURL.absoluteString)")
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
        handler: IOHTTPClient.Handler?
    ) -> IOCancellable {
        // Obtain task
        let task = request(
            method: type.rawValue,
            path: path,
            contentType: contentType,
            headers: headers,
            body: body,
            query: query,
            handler: handler
        )
        
        // Create a background task
        beginBackgroundTask(identifier: task.taskIdentifier)
        
        // Log call
        httpLogger.requestDidStart(task: task)
        
        // Create cancellable object
        let cancellable = IOHTTPRequestCancel(sessionTask: task)
        
        // Start task
        task.resume()
        
        // Return value
        return cancellable
    }
    
    public func setDefaultHTTPHeaders(headers: [String: String]?) {
        appState.set(object: headers, forType: .httpClientDefaultHeaders)
    }
    
    // MARK: - Helper Methods
    
    private func httpHeaders(with headers: [String: String]?, contentType: String) -> [String: String] {
        var httpHeaders = [String: String]()
        
        if let defaultHeaders = defaultHTTPHeaders {
            for (key, value) in defaultHeaders {
                httpHeaders[key] = value
            }
        }
        
        if let requestHeaders = headers {
            for (key, value) in requestHeaders {
                httpHeaders[key] = value
            }
        }
        
        httpHeaders["Content-Type"] = contentType
        return httpHeaders
    }
    
    private func request(
        method: String,
        path: String,
        contentType: String,
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
            requestURL = baseURL.appendingPathComponent(path)
        }
        if let urlQuery = query {
            requestURL = URL(string: String(format: "%@?%@", requestURL.absoluteString, urlQuery))!
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = method
        request.httpBody = body
        
        let httpHeaders = httpHeaders(with: headers, contentType: contentType)
        for (headerKey, headerValue) in httpHeaders {
            request.setValue(headerValue, forHTTPHeaderField: headerKey)
        }
        
        // Create a task
        var task: URLSessionTask?
        task = session.dataTask(with: request) { data, response, error in
            // Obtain values
            let httpResponse = response as? HTTPURLResponse
            let responseHeaders = httpResponse?.allHeaderFields as? [String: String]
            let statusCode = httpResponse?.statusCode ?? 0
            let taskIdentifier = task?.taskIdentifier ?? 0
            
            // End background task
            endBackgroundTask(identifier: taskIdentifier)
            
            // Log call
            httpLogger.requestDidFinish(task: task, responseObject: data, error: error as NSError?)
            
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
                thread.runOnMainThread {
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
                thread.runOnMainThread {
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
            thread.runOnMainThread {
                handler?(httpResult)
            }
        }
        
        return task!
    }
    
    // MARK: - Background Task
    
    private func beginBackgroundTask(identifier: Int) {
        let backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask {
            endBackgroundTask(identifier: identifier)
        }
        
        var backgroundTasks = backgroundTasks
        backgroundTasks?[identifier] = backgroundTaskIdentifier
        appState.set(object: backgroundTasks, forType: .httpClientBackgroundTasks)
    }
    
    private func endBackgroundTask(identifier: Int) {
        guard let backgroundTaskIdentifier = backgroundTasks?[identifier] else { return }
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        
        var backgroundTasks = backgroundTasks
        backgroundTasks?.removeValue(forKey: identifier)
        appState.set(object: backgroundTasks, forType: .httpClientBackgroundTasks)
    }
}
