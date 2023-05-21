//
//  IOServiceProvider.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Dispatch
import Foundation
import IOSwiftUICommon

public protocol IOServiceProvider {
    
    associatedtype ServiceType: IOServiceType
    
    // MARK: - Types
    
    typealias CancelHandler = (_ cancellable: IOCancellable?) -> Void
    typealias HTTPGroupHandler = (_ group: DispatchGroup?) -> Void
    typealias HTTPGroupCompleteHandler = () -> Void
    typealias ResultHandler<TModel: Codable> = (_ result: IOServiceResult<TModel>) -> Void
    
    // MARK: - Request Methods
    
    @discardableResult
    func async<TModel: Codable>(_ type: ServiceType, responseType: TModel.Type) async -> IOServiceResult<TModel>
   
    @discardableResult
    func async<TModel: Codable>(_ type: ServiceType, responseType: TModel.Type, cancelHandler: CancelHandler?) async -> IOServiceResult<TModel>
    
    // MARK: - HTTPGroup
    
    func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?)
}
