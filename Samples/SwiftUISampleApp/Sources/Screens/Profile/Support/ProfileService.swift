//
//  ProfileService.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import SwiftUISampleAppCommon
import IOSwiftUICommon
import IOSwiftUIInfrastructure

enum ProfileService {
    
    case createInbox(request: CreateInboxRequestModel)
    case follow(request: MemberFollowingRequestModel)
    case memberGet(request: MemberGetRequestModel)
    case memberGetImages(request: MemberImagesRequestModel)
    case unFollow(request: MemberFollowingRequestModel)
}

extension ProfileService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .createInbox:
            return .post
            
        case .follow:
            return .post
            
        case .memberGetImages:
            return .post
            
        case .unFollow:
            return .post
            
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
        case .createInbox:
            return "DirectMessage/CreateInbox"
            
        case .follow:
            return "MemberFollowing/Follow"
            
        case .memberGet:
            return "Member/Get"
            
        case .memberGetImages:
            return "MemberImages/GetImages"
            
        case .unFollow:
            return "MemberFollowing/UnFollow"
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
        case .memberGet(request: let request):
            return handleQuery(request)
            
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createInbox(request: let request):
            return handleRequest(request)
            
        case .follow(request: let request):
            return handleRequest(request)

        case .memberGetImages(request: let request):
            return handleRequest(request)
            
        case .unFollow(request: let request):
            return handleRequest(request)
            
        default:
            return nil
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
