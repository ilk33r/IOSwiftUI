// 
//  RegisterService.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

enum RegisterService {

    case register(request: RegisterMemberRequestModel)
}

extension RegisterService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .register:
            return .put        
        }
    }
    
    var requestContentType: IOServiceContentType {
        switch self {    
        default:
            return .applicationJSON
        }
    }
    
    var path: String {
        switch self {            
        case .register:
            return "MemberRegister/Register"        
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
        case .register(request: let request):
            return handleRequest(request)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
