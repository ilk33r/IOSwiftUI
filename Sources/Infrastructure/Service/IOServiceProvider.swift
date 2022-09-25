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
    
    // MARK: - Types
    
    typealias HTTPGroupHandler = (_ group: DispatchGroup?) -> Void
    typealias HTTPGroupCompleteHandler = () -> Void
    typealias ResultHandler<TModel: Codable> = (_ result: IOServiceResult<TModel>?) -> Void
    
    // MARK: - Request Methods
    
    func request<TModel: Codable>(_ type: IOServiceType, responseType: TModel.Type, handler: ResultHandler<TModel>?) -> IOCancellable?
    
    // MARK: - HTTPGroup
    
    func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?)
}
