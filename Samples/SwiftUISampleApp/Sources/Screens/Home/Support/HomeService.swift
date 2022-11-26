//
//  HomeService.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

enum HomeService {

    case addMemberImage(image: Data, boundary: String = UUID().uuidString)
}

extension HomeService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .put
        }
    }
    
    var requestContentType: IOServiceContentType {
        switch self {
        case .addMemberImage(_, boundary: let boundary):
            return .multipartFormData(boundary: boundary)
        }
    }
    
    var path: String {
        switch self {
        default:
            return "MemberImages/AddMemberImage"
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
        case .addMemberImage(image: let image, boundary: let boundary):
            let fileName = UUID().uuidString + ".png"
            let formData = IOServiceMultipartFormData(formName: "file", contentType: .imagePNG, content: image, fileName: fileName)
            return handleMultipartRequest([formData], boundary: boundary)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
