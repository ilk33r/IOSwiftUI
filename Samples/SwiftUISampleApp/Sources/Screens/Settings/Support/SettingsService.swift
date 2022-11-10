// 
//  SettingsService.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

enum SettingsService {

    case uploadProfilePicture(name: String, type: String, image: Data)
}

extension SettingsService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .uploadProfilePicture:
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
        case .uploadProfilePicture:
            return "MemberImages/UploadProfilePicture"
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
