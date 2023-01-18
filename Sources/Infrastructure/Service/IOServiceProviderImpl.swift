//
//  IOServiceProviderImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOServiceProviderImpl<TType: IOServiceType>: IOServiceProvider {

    // MARK: - Types
    
    public typealias ServiceType = TType
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClient
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Request Methods
    
    @discardableResult
    public func request<TModel: Codable>(_ type: TType, responseType: TModel.Type, handler: @escaping ResultHandler<TModel>) -> IOCancellable? {
        return httpClient.request(
            type: type.methodType,
            path: type.path,
            contentType: type.requestContentType.rawValue,
            headers: type.headers,
            query: type.query,
            body: type.body
        ) { result in
            let response = type.response(responseType: responseType, result: result)
            handler(response)
        }
    }
    
    @discardableResult
    public func async<TModel: Codable>(_ type: TType, responseType: TModel.Type) async -> IOServiceResult<TModel> {
        let response = await withCheckedContinuation { contination in
            _ = httpClient.request(
                type: type.methodType,
                path: type.path,
                contentType: type.requestContentType.rawValue,
                headers: type.headers,
                query: type.query,
                body: type.body
            ) { result in
                let handledResult = type.response(responseType: responseType, result: result)
                contination.resume(returning: handledResult)
            }
        }
        
        return response
    }
    
    // MARK: - HTTPGroup
    
    public func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?) {
        let group = DispatchGroup()
        groupHandler?(group)
        
        group.notify(queue: DispatchQueue.main) {
            completeHandler?()
        }
    }
}
