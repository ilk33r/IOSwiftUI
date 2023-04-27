//
//  AuthenticationService.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.04.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon

public enum AuthenticationService {
    
    case authenticate(request: AuthenticateRequestModel)
}

extension AuthenticationService: IOServiceType {
    
    public var methodType: IOHTTPRequestType {
        switch self {
        case .authenticate:
            return .post
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
        case .authenticate:
            return "MemberLogin/Authenticate"
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
        default:
            return nil
        }
    }
    
    public var body: Data? {
        switch self {
        case .authenticate(let request):
            return handleRequest(request)
        }
    }
    
    public func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
