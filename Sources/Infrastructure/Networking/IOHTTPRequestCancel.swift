//
//  IOHTTPRequestCancel.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

internal struct IOHTTPRequestCancel: IOCancellable {
    
    private var sessionTask: URLSessionTask?
    
    init(sessionTask: URLSessionTask?) {
        self.sessionTask = sessionTask
    }
    
    func cancel() {
        sessionTask?.cancel()
    }
}
