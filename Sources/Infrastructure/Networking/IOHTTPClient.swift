//
//  IOHTTPClient.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

public typealias IOHTTPClientHandler = (_ result: IOHTTPResult?) -> Void

public protocol IOHTTPClient {
    
    // MARK: - Http Client Methods
    
    @discardableResult
    func request(
        type: IOHTTPRequestType,
        path: String,
        headers: [String: String]?,
        query: String?,
        body: Data,
        handler: IOHTTPClientHandler?
    ) -> IOCancellable
    
    func setDefaultHTTPHeaders(headers: [String: String]?)
}
