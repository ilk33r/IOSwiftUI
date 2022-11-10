//
//  SplashService.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppInfrastructure

enum SplashService {
    
    case checkToken
    case handshake
}

extension SplashService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .get
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
        case .checkToken:
            return "MemberLogin/CheckToken"
            
        case .handshake:
            return "HandshakeDefault/Index"
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
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
