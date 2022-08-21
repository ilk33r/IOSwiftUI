//
//  IOInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure

open class IOInteractor<TPresenter: IOPresenterable, TEntity: IOEntity>: IOInteractorable {
    
    // MARK: - Interactorable
    
    public var _entityInstance: Any!
    public weak var _presenterInstance: AnyObject!
    
    public typealias Entity = TEntity
    public typealias Presenter = TPresenter
    
    // MARK: - HTTP
    
    public typealias HTTPGroupHandler = (_ group: DispatchGroup?) -> Void
    public typealias HTTPGroupCompleteHandler = () -> Void
    
    // MARK: - DI
    
    @IOInject private var _appState: IOAppStateImpl
    @IOInject private var _configuration: IOConfigurationImpl
    @IOInject private var _localization: IOLocalizationImpl
    
    public var appState: IOAppState { self._appState }
    public var configuration: IOConfiguration { self._configuration }
    public var localization: IOLocalization { self._localization }
    
    // MARK: - Init
    
    required public init() {
    }
    
    // MARK: - HTTP
    /*
    open func _handleQuery<TModel: Codable>(_ model: TModel) -> String? {
        do {
            let jsonData = try JSONEncoder().encode(model)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard let jsonDictionary = dictionary as? [String: Any] else { return nil }
            let encodedDictionary = jsonDictionary
                .compactMap({ key, value -> String? in
                    if value is Int {
                        return String(format: "%@=%d", key, value as! Int)
                    } else if value is String {
                        return String(format: "%@=%@", key, value as! String)
                    }
                    
                    return nil
                })
                .joined(separator: "&")
            
            return encodedDictionary
        } catch let jsonError {
            LogError("Model encode error: \(jsonError.localizedDescription)")
        }
        
        return nil
    }
    
    open func _handleRequest<TModel: Codable>(_ model: TModel) -> Data {
        do {
            return try JSONEncoder().encode(model)
        } catch let jsonError {
            LogError("Model encode error: \(jsonError.localizedDescription)")
        }
        
        return Data()
    }
    
    open func _handleResponse<TModel: Codable>(
        type: TModel.Type,
        result: HPHTTPResult?
    ) -> HPServiceResult<TModel> {
        // Check error
        if let httpError = result?.error {
            return HPServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType)
        }
        
        let httpError = HPHTTPError(code: 0, errorType: .decodeError)
        guard let resultData = result?.data else {
            return HPServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType)
        }
        
        do {
            let responseModel = try JSONDecoder().decode(TModel.self, from: resultData)
            return HPServiceResult<TModel>.success(response: responseModel)
        } catch let jsonError {
            LogError("JSON Decode Error: \(jsonError.localizedDescription)")
            return HPServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType)
        }
    }
    */
    open func createHttpGroup(_ groupHandler: HTTPGroupHandler?, completeHandler: HTTPGroupCompleteHandler?) {
        let group = DispatchGroup()
        groupHandler?(group)
        
        group.notify(queue: DispatchQueue.main) {
            completeHandler?()
        }
    }
}
