//
//  IOThreadImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.10.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOThreadImpl: IOThread {
    
    // MARK: - Privates
    
    private let queue: DispatchQueue
    
    // MARK: - Initialization Methods
    
    public init() {
        self.queue = DispatchQueue(label: "com.ioswiftui.infrastructure." + UUID().uuidString)
    }
    
    // MARK: - Thread
    
    @discardableResult
    public func runOnBackgroundThread(_ handler: @escaping IOThread.Block) -> IOCancellable {
        let workItem = DispatchWorkItem {
            handler()
        }
        
        let cancellable = IOThreadCancel(workItem: workItem)
        queue.async(execute: workItem)
        return cancellable
    }
    
    @discardableResult
    public func runOnBackgroundThread(afterMilliSecond: Int, _ handler: @escaping Block) -> IOCancellable {
        let workItem = DispatchWorkItem {
            handler()
        }
        
        let cancellable = IOThreadCancel(workItem: workItem)
        queue.asyncAfter(deadline: .now() + .milliseconds(afterMilliSecond), execute: workItem)
        return cancellable
    }
    
    @discardableResult
    public func runOnMainThread(_ handler: @escaping IOThread.Block) -> IOCancellable {
        let workItem = DispatchWorkItem {
            handler()
        }
        
        let cancellable = IOThreadCancel(workItem: workItem)
        DispatchQueue.main.async(execute: workItem)
        return cancellable
    }
    
    @discardableResult
    public func runOnMainThread(afterMilliSecond: Int, _ handler: @escaping Block) -> IOCancellable {
        let workItem = DispatchWorkItem {
            handler()
        }
        
        let cancellable = IOThreadCancel(workItem: workItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(afterMilliSecond), execute: workItem)
        return cancellable
    }
}
