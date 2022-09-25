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
        return self._handleQuery(model)
    }
    
    func handleRequest<TModel: BaseRequestModel>(_ model: TModel) -> Data? {
        return self._handleRequest(model)
    }
    
    func handleResponse<TModel: BaseResponseModel>(
        type: TModel.Type,
        result: IOHTTPResult?
    ) -> IOServiceResult<TModel> {
        let result = self._handleResponse(type: type, result: result)
        
        switch result {
        case .success(response: let response):
            if response.status?.success ?? false {
                return result
            } else {
                return IOServiceResult<TModel>.error(
                    message: response.status?.message ?? IOLocalizationType.networkCommonError.localized,
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
