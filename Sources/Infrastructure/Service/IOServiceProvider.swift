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
    
    typealias HTTPGroupHandler = (_ group: DispatchGroup?) -> Void
    typealias HTTPGroupCompleteHandler = () -> Void
    typealias ResultHandler<TModel: Codable> = (_ result: IOServiceResult<TModel>) -> Void
    
    // MARK: - Request Methods
    
    @discardableResult
    func request<TModel: Codable>(_ type: ServiceType, responseType: TModel.Type, handler: @escaping ResultHandler<TModel>) -> IOCancellable?
    
    // MARK: - HTTPGroup
    
    func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?)
}
