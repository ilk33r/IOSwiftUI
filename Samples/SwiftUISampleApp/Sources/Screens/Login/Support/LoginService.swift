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
    
    case biometricToken(request: BiometricAuthenticateRequestModel)
    case authenticateWithBiometric(request: AuthenticateWithBiometricRequestModel)
}

extension LoginService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .biometricToken:
            return .post
            
        case .authenticateWithBiometric:
            return .post
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
        case .biometricToken:
            return "MemberLogin/BiometricToken"
            
        case .authenticateWithBiometric:
            return "MemberLogin/AuthenticateWithBiometric"
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
        case .biometricToken(request: let request):
            return handleRequest(request)
            
        case .authenticateWithBiometric(request: let request):
            return handleRequest(request)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
