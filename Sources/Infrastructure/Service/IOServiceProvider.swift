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
    
    @available(*, deprecated, message: "Use async")
    @discardableResult
    func request<TModel: Codable>(_ type: ServiceType, responseType: TModel.Type, handler: @escaping ResultHandler<TModel>) -> IOCancellable?
    
    @discardableResult
    func async<TModel: Codable>(_ type: ServiceType, responseType: TModel.Type) async -> IOServiceResult<TModel>
    
    // MARK: - HTTPGroup
    
    func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?)
}
