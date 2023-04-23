//
//  ChatInboxService.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon

enum ChatInboxService {
    
    case deleteInbox(request: DeleteInboxRequestModel)
    case getInboxes
}

extension ChatInboxService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .deleteInbox:
            return .delete
            
        default:
            return .get
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
        case .deleteInbox:
            return "DirectMessage/DeleteInbox"
            
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
        case .deleteInbox(request: let request):
            return handleQuery(request)
            
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
        handleResponse(type: responseType, result: result)
    }
}
