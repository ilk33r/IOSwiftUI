//
//  IOThreadCancel.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.10.2022.
//

import Foundation
import IOSwiftUICommon

final class IOThreadCancel: IOCancellable {
    
    // MARK: - Privatees
    
    private var workItem: DispatchWorkItem?
    
    // MARK: - Initialization Methods
    
    init(workItem: DispatchWorkItem?) {
        self.workItem = workItem
    }
    
    // MARK: - Cancellable
    
    func cancel() {
        self.workItem?.cancel()
    }
}
