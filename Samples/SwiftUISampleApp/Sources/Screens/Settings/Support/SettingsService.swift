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
    case uploadProfilePicture(image: Data, boundary: String = UUID().uuidString)
}

extension SettingsService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .deleteProfilePicture:
            return .delete
            
        case .pairFaceID:
            return .post
            
        case .uploadProfilePicture:
            return .put
        }
    }
    
    var requestContentType: IOServiceContentType {
        switch self {
        case .uploadProfilePicture(_, let boundary):
            return .multipartFormData(boundary: boundary)
            
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
        case .pairFaceID(request: let request):
            return handleRequest(request)
            
        case .uploadProfilePicture(image: let image, boundary: let boundary):
            let fileName = UUID().uuidString + ".png"
            let formData = IOServiceMultipartFormData(formName: "file", contentType: .imagePNG, content: image, fileName: fileName)
            return handleMultipartRequest([formData], boundary: boundary)
            
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
