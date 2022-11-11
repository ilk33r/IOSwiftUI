//
//  ServiceTypeExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon

public extension IOServiceType {
    
    func handleQuery<TModel: BaseRequestModel>(_ model: TModel) -> String? {
        return _handleQuery(model)
    }
    
    func handleRequest<TModel: BaseRequestModel>(_ model: TModel) -> Data? {
        return _handleRequest(model)
    }
    
    func handleMultipartRequest(_ data: [IOServiceMultipartFormData], boundary: String) -> Data? {
        return _handleMultipartRequest(data, boundary: boundary)
    }
    
    func handleResponse<TModel: Codable>(
        type: TModel.Type,
        result: IOHTTPResult?
    ) -> IOServiceResult<TModel> {
        let result = _handleResponse(type: type, result: result)
        
        switch result {
        case .success(response: let response):
            let baseResponse = response as? BaseResponseModel
            if baseResponse?.status?.success ?? false {
                return result
            } else {
                return IOServiceResult<TModel>.error(
                    message: baseResponse?.status?.message ?? IOLocalizationType.networkCommonError.localized,
                    type: .responseStatusError,
                    response: response
                )
            }
            
        case .error(message: _, type: let type, response: let response):
            if type == .notConnectedToInternet {
                return IOServiceResult<TModel>.error(
                    message: IOLocalizationType.networkConnectionError.localized,
                    type: type,
                    response: response
                )
            } else {
                return result
            }
        }
    }
}
