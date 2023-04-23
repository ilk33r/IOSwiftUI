// 
//  ChangePasswordService.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

enum ChangePasswordService {

    case changePassword(request: ChangePasswordRequestModel)
}

extension ChangePasswordService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .changePassword:
            return .patch
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
        case .changePassword:
            return "MemberUpdate/ChangePassword"
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
        case .changePassword(request: let request):
            return handleRequest(request)
            
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
