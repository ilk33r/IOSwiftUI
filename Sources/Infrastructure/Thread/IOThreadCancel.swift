//
//  IOThreadCancel.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.10.2022.
//

import Foundation
import IOSwiftUICommon

internal struct IOThreadCancel: IOCancellable {
    
    // MARK: - Privatees
    
    private var workItem: DispatchWorkItem?
    
    // MARK: - Initialization Methods
    
    init(workItem: DispatchWorkItem?) {
        self.workItem = workItem
    }
    
    // MARK: - Cancellable
    
    func cancel() {
        workItem?.cancel()
    }
}
