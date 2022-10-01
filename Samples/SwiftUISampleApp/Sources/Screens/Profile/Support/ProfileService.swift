//
//  ProfileService.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import SwiftUISampleAppCommon
import IOSwiftUICommon
import IOSwiftUIInfrastructure

enum ProfileService {
    
    case memberGet(request: MemberGetRequestModel)
}

extension ProfileService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .memberGet:
            return "Member/Get"
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
        case .memberGet(request: let request):
            return self.handleQuery(request)
        }
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return self.handleResponse(type: responseType, result: result)
    }
}
