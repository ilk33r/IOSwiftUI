//
//  IOMapper.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

public protocol IOMapper {
    
    // MARK: - Mapper Methods
    
    func mapJson<TModel: Codable>(model: TModel.Type, data: Data) throws -> TModel
    func mapJson<TModel: Codable>(model: TModel.Type, string: String) throws -> TModel
    
    func toJsonData<TModel: Codable>(_ model: TModel) throws -> Data
    func toJsonString<TModel: Codable>(_ model: TModel) throws -> String
}
