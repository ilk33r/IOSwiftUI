// 
//  UpdateProfileService.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

enum UpdateProfileService {

    case updateMember(request: RegisterMemberRequestModel)
}

extension UpdateProfileService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .updateMember:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .updateMember:
            return "MemberUpdate/UpdateMember"
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
        case .updateMember(let request):
            return handleRequest(request)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
