//
//  ProfilePictureService.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.04.2023.
//

import Foundation
import IOSwiftUIInfrastructure

public enum ProfilePictureService {
    
    case uploadProfilePicture(image: Data, boundary: String = UUID().uuidString)
}

extension ProfilePictureService: IOServiceType {
    
    public var methodType: IOHTTPRequestType {
        switch self {
        case .uploadProfilePicture:
            return .put
        }
    }
    
    public var requestContentType: IOServiceContentType {
        switch self {
        case .uploadProfilePicture(_, let boundary):
            return .multipartFormData(boundary: boundary)
        }
    }
    
    public var path: String {
        switch self {
        case .uploadProfilePicture:
            return "MemberImages/UploadProfilePicture"
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
        case .uploadProfilePicture(image: let image, boundary: let boundary):
            let fileName = UUID().uuidString + ".png"
            let formData = IOServiceMultipartFormData(formName: "file", contentType: .imagePNG, content: image, fileName: fileName)
            return handleMultipartRequest([formData], boundary: boundary)
        }
    }
    
    public func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOSwiftUIInfrastructure.IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
