//
//  IOBaseService.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

enum IOBaseService {
    
    case ioGet
    case ioPost(request: IORequestModel)
}

extension IOBaseService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .ioGet:
            return .get
            
        case .ioPost:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .ioGet:
            return "io/get"
        case .ioPost:
            return "io/post"
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var query: String? {
        switch self {
        case .ioGet:
            return self._handleQuery(IORequestModel())
            
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case let .ioPost(request):
            return self._handleRequest(request)
            
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return self._handleResponse(type: responseType, result: result)
    }
}
