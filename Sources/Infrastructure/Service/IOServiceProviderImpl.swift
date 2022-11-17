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
    
    @IOInject private var appleSettings: IOAppleSettingImpl
    @IOInject private var _httpClient: IOHTTPClientImpl
    @IOInject private var _simulationHttpClient: IOHTTPClientSimulationImpl
    
    private var httpClient: IOHTTPClient {
        if appleSettings.bool(for: .debugSimulateHTTPClient) {
            return _simulationHttpClient
        }
        
        return _httpClient
    }
    
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
    
    // MARK: - HTTPGroup
    
    public func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?) {
        let group = DispatchGroup()
        groupHandler?(group)
        
        group.notify(queue: DispatchQueue.main) {
            completeHandler?()
        }
    }
}
