//
//  IOThread.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.10.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOThread: IOObject {
    
    // MARK: - Defs
    
    typealias Block = () -> Void
    
    // MARK: - Thread Methods
    
    @discardableResult
    func runOnBackgroundThread(_ handler: @escaping Block) -> IOCancellable
    
    @discardableResult
    func runOnBackgroundThread(afterMilliSecond: Int, _ handler: @escaping Block) -> IOCancellable
    
    @discardableResult
    func runOnMainThread(_ handler: @escaping Block) -> IOCancellable
    
    @discardableResult
    func runOnMainThread(afterMilliSecond: Int, _ handler: @escaping Block) -> IOCancellable
}
