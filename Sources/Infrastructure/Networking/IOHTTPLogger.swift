//
//  IOHTTPLogger.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.11.2022.
//

import Foundation

public protocol IOHTTPLogger {
    
    var networkHistory: [IOHTTPNetworkHistory]! { get }
    
    // MARK: - Logger Methods
    
    func requestDidStart(task: URLSessionTask)
    func requestDidFinish(task: URLSessionTask?, responseObject: Any?, error: NSError?)
}
