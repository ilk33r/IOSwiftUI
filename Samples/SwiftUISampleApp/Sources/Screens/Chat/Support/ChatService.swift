//
//  ChatService.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon

enum ChatService {
    
    case sendMessage(request: SendMessageRequestModel)
}

extension ChatService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .sendMessage:
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
        case .sendMessage:
            return "DirectMessage/SendMessage"
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
        case .sendMessage(request: let request):
            return handleRequest(request)
        }
    }
    
    func response<TModel>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> where TModel: Decodable, TModel: Encodable {
        handleResponse(type: responseType, result: result)
    }
}
