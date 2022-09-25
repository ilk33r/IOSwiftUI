//
//  IOServiceProviderImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOServiceProviderImpl: IOServiceProvider, IOSingleton {

    // MARK: - Defs
    
    public typealias InstanceType = IOServiceProviderImpl
    public static var _sharedInstance: IOServiceProviderImpl!
    
    // MARK: - DI
    
    @IOInject private var httpClient: IOHTTPClientImpl
    
    // MARK: - Initialization Methods
    
    required public init() {
    }
    
    // MARK: - Request Methods
    
    public func request<TModel: Codable>(_ type: IOServiceType, responseType: TModel.Type, handler: ResultHandler<TModel>?) -> IOCancellable? {
        return self.httpClient.request(
            type: type.methodType,
            path: type.path,
            headers: type.headers,
            query: type.query,
            body: type.body
        ) { result in
            let response = type.response(responseType: responseType, result: result)
            handler?(response)
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
