//
//  IOServiceType.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOServiceType {
    
    var methodType: IOHTTPRequestType { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var query: String? { get }
    var body: Data? { get }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel>
}

public extension IOServiceType {
    
    var mapper: IOMapper { IOMapperImpl.shared }
    
    func _handleQuery<TModel: Codable>(_ model: TModel) -> String? {
        do {
            let jsonData = try self.mapper.toJsonData(model)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard let jsonDictionary = dictionary as? [String: Any] else { return nil }
            let encodedDictionary = jsonDictionary
                .compactMap({ key, value -> String? in
                    if value is Int {
                        return String(format: "%@=%d", key, value as! Int)
                    } else if
                        let stringValue = value as? String,
                        let encodedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                    {
                        return String(format: "%@=%@", key, encodedValue)
                    }
                    
                    return nil
                })
                .joined(separator: "&")
            
            return encodedDictionary
        } catch let jsonError {
            IOLogger.error("Model encode error: \(jsonError.localizedDescription)")
        }
        
        return nil
    }
    
    func _handleRequest<TModel: Codable>(_ model: TModel) -> Data? {
        do {
            return try self.mapper.toJsonData(model)
        } catch let jsonError {
            IOLogger.error("Model encode error: \(jsonError.localizedDescription)")
        }
        
        return nil
    }
    
    func _handleResponse<TModel: Codable>(
        type: TModel.Type,
        result: IOHTTPResult?
    ) -> IOServiceResult<TModel> {
        let httpError = IOHTTPError(code: 0, errorType: .decodeError)
        guard let resultData = result?.data else {
            // Check error
            if let httpError = result?.error {
                return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: nil)
            } else {
                return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: nil)
            }
        }
        
        do {
            let responseModel = try self.mapper.mapJson(model: type, data: resultData)
            
            if let httpError = result?.error {
                return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: responseModel)
            } else {
                return IOServiceResult<TModel>.success(response: responseModel)
            }
        } catch let jsonError {
            IOLogger.error("JSON Decode Error: \(jsonError.localizedDescription)")
            return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: nil)
        }
    }
}
