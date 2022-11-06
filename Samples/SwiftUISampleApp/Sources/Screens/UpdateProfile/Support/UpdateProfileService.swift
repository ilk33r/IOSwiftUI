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

enum UpdateProfileService {

}

extension UpdateProfileService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .get
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
        return handleResponse(type: responseType, result: result)
    }
}
