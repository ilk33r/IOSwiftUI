//
//  IOMapperImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

final public class IOMapperImpl: IOMapper, IOSingleton {

    // MARK: - Defs
    
    public typealias InstanceType = IOMapperImpl
    public static var _sharedInstance: IOMapperImpl!
    
    public enum MappingError: Error {
        case invalidModel
        case invalidJSON
    }
    
    // MARK: - Initialization Methods
    
    required public init() {
    }
    
    // MARK: - Mapper Methods
    
    public func mapJson<TModel: Codable>(model: TModel.Type, data: Data) throws -> TModel {
        return try JSONDecoder().decode(model, from: data)
    }
    
    public func mapJson<TModel: Codable>(model: TModel.Type, string: String) throws -> TModel {
        if let jsonData = string.data(using: .utf8) {
            return try self.mapJson(model: model, data: jsonData)
        }
        
        throw MappingError.invalidModel
    }
    
    public func toJsonData<TModel: Codable>(_ model: TModel) throws -> Data {
        return try JSONEncoder().encode(model)
    }
    
    public func toJsonString<TModel: Codable>(_ model: TModel) throws -> String {
        let jsonData = try self.toJsonData(model)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        
        throw MappingError.invalidJSON
    }
}