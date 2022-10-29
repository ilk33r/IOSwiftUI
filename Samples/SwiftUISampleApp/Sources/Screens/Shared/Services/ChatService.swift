//
//  ChatService.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

public enum ChatService {
    
    case getMessages(request: GetMessagesRequestModel)
}

extension ChatService: IOServiceType {
    
    public var methodType: IOHTTPRequestType {
        switch self {
        case .getMessages:
            return .post
        }
    }
    
    public var path: String {
        switch self {
        case .getMessages:
            return "DirectMessage/GetMessages"
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
        case .getMessages(let request):
            return self.handleRequest(request)
        }
    }
    
    public func response<TModel>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> where TModel: Decodable, TModel: Encodable {
        return self.handleResponse(type: responseType, result: result)
    }
}
