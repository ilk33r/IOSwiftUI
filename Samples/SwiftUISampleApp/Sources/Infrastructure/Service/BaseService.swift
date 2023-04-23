//
//  BaseService.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon

public enum BaseService {
    
    case imageAsset(request: ImageAssetRequestModel)
}

extension BaseService: IOServiceType {
    
    public var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .get
        }
    }
    
    public var requestContentType: IOServiceContentType {
        switch self {
        default:
            return .applicationJSON
        }
    }
    
    public var path: String {
        switch self {
        case .imageAsset:
            return "ImageAsset/Get"
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var query: String? {
        switch self {
        case .imageAsset(request: let request):
            return handleQuery(request)
        }
    }
    
    public var body: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    public func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        if result?.path.contains("ImageAsset/Get") ?? false {
            return handleImageDataResponse(responseType: responseType, result: result)
        }
        
        return handleResponse(type: responseType, result: result)
    }
    
    private func handleImageDataResponse<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        let httpError = IOHTTPError(code: 0, errorType: .decodeError)
        guard let resultData = result?.data else {
            // Check error
            if let httpError = result?.error {
                return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: nil)
            } else {
                return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: nil)
            }
        }
        
        if responseType is ImageAssetResponseModel.Type {
            let model = ImageAssetResponseModel(data: resultData)
            return IOServiceResult<TModel>.success(response: (model as? TModel)!)
        } else {
            return IOServiceResult<TModel>.error(message: httpError.errorMessage, type: httpError.errorType, response: nil)
        }
    }
}
