// 
//  RegisterService.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

enum RegisterService {

    case checkMember(request: CheckMemberRequestModel)
    case checkMemberUserName(request: CheckMemberUserNameRequestModel)
    case register(request: RegisterMemberRequestModel)
    case authenticate(request: AuthenticateRequestModel)
    case uploadProfilePicture(image: Data, boundary: String = UUID().uuidString)
}

extension RegisterService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .checkMember:
            return .post
            
        case .checkMemberUserName:
            return .post
            
        case .register:
            return .put
            
        case .authenticate:
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
        case .checkMember:
            return "MemberRegister/CheckMember"
            
        case .checkMemberUserName:
            return "MemberRegister/CheckMemberUserName"
            
        case .register:
            return "MemberRegister/Register"
            
        case .authenticate:
            return "MemberLogin/Authenticate"
            
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
        case .checkMember(request: let request):
            return handleRequest(request)
            
        case .checkMemberUserName(request: let request):
            return handleRequest(request)
            
        case .register(request: let request):
            return handleRequest(request)
            
        case .authenticate(request: let request):
            return handleRequest(request)
            
        case .uploadProfilePicture(image: let image, boundary: let boundary):
            let fileName = UUID().uuidString + ".png"
            let formData = IOServiceMultipartFormData(formName: "file", contentType: .imagePNG, content: image, fileName: fileName)
            return handleMultipartRequest([formData], boundary: boundary)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
