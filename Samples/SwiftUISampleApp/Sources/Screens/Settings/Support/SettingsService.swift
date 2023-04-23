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
import SwiftUISampleAppCommon

enum SettingsService {

    case deleteProfilePicture
    case pairFaceID(request: MemberPairFaceIDRequestModel)
}

extension SettingsService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .deleteProfilePicture:
            return .delete
            
        case .pairFaceID:
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
        case .deleteProfilePicture:
            return "MemberImages/DeleteProfilePicture"
            
        case .pairFaceID:
            return "MemberRegister/PairFaceID"
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
        case .pairFaceID(request: let request):
            return handleRequest(request)
            
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
