//
//  IOHTTPLogger.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

final public class IOHTTPLogger: IOSingleton {
    
    public typealias InstanceType = IOHTTPLogger
    public static var _sharedInstance: IOHTTPLogger!
    
    // MARK: - Constants
    
    private let seperatorLength = 32
    private let failureIcon = "\u{0000274C}"
    private let successIcon = "\u{00002705}"
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfigurationImpl
    @IOInstance private var thread: IOThreadImpl
    
    // MARK: - Defs
    
    public struct NetworkHistory {
        public var path: String
        public var requestHeaders: String
        public var requestBody: String
        public var responseHeaders: String
        public var responseBody: String
        public var responseStatusCode: Int
    }
    
    public private(set) var networkHistory: [NetworkHistory]!
    
    // MARK: - Privates
    
    private var requestBodies: [Int: String]
    
    // MARK: - Initialization Methods
    
    public init() {
        self.requestBodies = [:]
        self.networkHistory = []
    }
    
    // MARK: - Logger Methods
    
    func requestDidStart(task: URLSessionTask) {
        if self.configuration.environment == .prod {
            return
        }
        
        guard let urlRequest = task.originalRequest else { return }
        
        let body: String
        if let bodyData = urlRequest.httpBody {
            body = String(data: bodyData, encoding: .utf8) ?? ""
        } else {
            body = ""
        }
        
        self.requestBodies[task.taskIdentifier] = body
    }
    
    func requestDidFinish(task: URLSessionTask?, responseObject: Any?, error: NSError?) {
        if self.configuration.environment == .prod {
            return
        }
        
        guard let sessionTask = task else { return }
        guard let urlRequest = sessionTask.originalRequest else { return }
        guard let urlResponse = sessionTask.response as? HTTPURLResponse else { return }
        
        let requestHeaders = self.jsonStringFromObject(object: urlRequest.allHTTPHeaderFields ?? [String: String]())
        let requestBody = self.requestBodies[sessionTask.taskIdentifier]
        let requestLog = String(
            format: "%@ %@ '%@':\n%@\n%@",
            self.separatorString(),
            urlRequest.httpMethod ?? "",
            urlRequest.url?.absoluteString ?? "",
            requestHeaders,
            requestBody ?? ""
        )
        
        // Log call
        self.thread.runOnBackgroundThread {
            IOLogger.debug(requestLog)
        }
        
        if let requestError = error {
            let responseHeaders = self.jsonStringFromObject(object: urlResponse.allHeaderFields)
            let responseBody = self.jsonStringFromObject(object: requestError)
            let responseLog = String(
                format: "%@ %@ '%@' (%ld) :\n%@%@",
                self.failureIcon,
                urlRequest.httpMethod ?? "",
                urlResponse.url?.absoluteString ?? "",
                urlResponse.statusCode,
                responseBody,
                self.separatorString()
            )
            
            // Log call
            self.thread.runOnBackgroundThread {
                IOLogger.debug(responseLog)
            }

            let path = String(
                format: "%@ %@",
                self.failureIcon,
                urlResponse.url?.absoluteString ?? ""
            )
            let networkHistoryItem = NetworkHistory(path: path, requestHeaders: requestHeaders, requestBody: requestBody ?? "", responseHeaders: responseHeaders, responseBody: responseBody, responseStatusCode: urlResponse.statusCode)
            self.networkHistory.append(networkHistoryItem)
        } else {
            var responseBody: String
            if let responseData = responseObject as? Data {
                let responseJSON = try? JSONSerialization.jsonObject(with: responseData, options: .init(rawValue: 0))
                
                if let responseObject = responseJSON {
                    responseBody = self.jsonStringFromObject(object: responseObject)
                } else {
                    responseBody = self.jsonStringFromObject(object: responseObject ?? [])
                }
            } else {
                responseBody = self.jsonStringFromObject(object: responseObject ?? [])
            }
            
            let responseHeaders = self.jsonStringFromObject(object: urlResponse.allHeaderFields)
            let responseLog = String(
                format: "%@ %ld '%@' :\n%@\n",
                self.successIcon,
                urlResponse.statusCode,
                urlResponse.url?.absoluteString ?? "",
                responseHeaders
            )
            let separatorString = self.separatorString()
            
            // Log call
            self.thread.runOnBackgroundThread {
                IOLogger.debug(responseLog)
                IOLogger.debug("\n\(responseBody)")
                IOLogger.debug(separatorString)
            }
            
            let path = String(
                format: "%@ %@",
                self.successIcon,
                urlResponse.url?.absoluteString ?? ""
            )
            let networkHistoryItem = NetworkHistory(path: path, requestHeaders: requestHeaders, requestBody: requestBody ?? "", responseHeaders: responseHeaders, responseBody: responseBody, responseStatusCode: urlResponse.statusCode)
            self.networkHistory.append(networkHistoryItem)
        }
        
        // Remove request from dictionary
        self.requestBodies.removeValue(forKey: sessionTask.taskIdentifier)
    }
    
    // MARK: - Helper Methods
    
    private func jsonStringFromObject(object: Any) -> String {
        if let dataObject = object as? Data {
            return String(data: dataObject, encoding: .utf8) ?? ""
        }
        
        guard let jsonObject = object as? [String: Any] else {
            return ""
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString ?? ""
        } catch {
            return ""
        }
    }
    
    private func separatorString() -> String {
        let separator = String(repeating: "-", count: self.seperatorLength)
        return String(format: "\n%@\n", separator)
    }
    
}
