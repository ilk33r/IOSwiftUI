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
    
}

extension LoginService: IOServiceType {
    
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
        default:
            return ""
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
        handleResponse(type: responseType, result: result)
    }
}
