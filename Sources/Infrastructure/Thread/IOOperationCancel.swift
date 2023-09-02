//
//  IOOperationCancel.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2023.
//

import Foundation
import IOSwiftUICommon

internal class IOOperationCancel: IOCancellable {
    
    // MARK: - Privatees
    
    private var operationQueue: OperationQueue?
    
    // MARK: - Initialization Methods
    
    init(operationQueue: OperationQueue?) {
        self.operationQueue = operationQueue
    }
    
    deinit {
        self.operationQueue = nil
    }
    
    // MARK: - Cancellable
    
    func cancel() {
        operationQueue?.cancelAllOperations()
        operationQueue = nil
    }
}
