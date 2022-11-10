//
//  IOHTTPClient.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOHTTPClient {
    
    // MARK: - Defs
    
    typealias Handler = (_ result: IOHTTPResult?) -> Void
    
    // MARK: - Publics
    
    var defaultHTTPHeaders: [String: String]? { get }
    
    // MARK: - Http Client Methods
    
    @discardableResult
    func request(
        type: IOHTTPRequestType,
        path: String,
        contentType: String,
        headers: [String: String]?,
        query: String?,
        body: Data?,
        handler: Handler?
    ) -> IOCancellable
    
    func setDefaultHTTPHeaders(headers: [String: String]?)
}
