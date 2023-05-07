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
    case checkMember(request: CheckMemberRequestModel)
    case checkMemberUserName(request: CheckMemberUserNameRequestModel)
}

extension AuthenticationService: IOServiceType {
    
    public var methodType: IOHTTPRequestType {
        switch self {
        case .authenticate:
            return .post
            
        case .checkMember:
            return .post
            
        case .checkMemberUserName:
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
            
        case .checkMember:
            return "MemberRegister/CheckMember"
            
        case .checkMemberUserName:
            return "MemberRegister/CheckMemberUserName"
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
            
        case .checkMember(request: let request):
            return handleRequest(request)
            
        case .checkMemberUserName(request: let request):
            return handleRequest(request)
        }
    }
    
    public func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
