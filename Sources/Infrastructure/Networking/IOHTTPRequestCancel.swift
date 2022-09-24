//
//  IOHTTPRequestCancel.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

internal class IOHTTPRequestCancel: IOCancellable {
    
    private var sessionTask: URLSessionTask?
    
    init(sessionTask: URLSessionTask) {
        self.sessionTask = sessionTask
    }
    
    func cancel() {
        self.sessionTask?.cancel()
        self.sessionTask = nil
    }
}
