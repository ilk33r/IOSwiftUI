//
//  LoginService.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

enum LoginService {
    
    case authenticate(request: AuthenticateRequestModel)
}

extension LoginService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .authenticate:
            return .post
            
//        default:
//            return .get
        }
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "MemberLogin/Authenticate"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var query: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .authenticate(let request):
            return handleRequest(request)
            
//        default:
//            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
