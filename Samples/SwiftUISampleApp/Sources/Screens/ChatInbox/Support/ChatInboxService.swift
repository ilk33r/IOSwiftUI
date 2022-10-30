//
//  ChatInboxService.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

enum ChatInboxService {
    
    case getInboxes
}

extension ChatInboxService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getInboxes:
            return "DirectMessage/GetInboxes"
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
        return self.handleResponse(type: responseType, result: result)
    }
}