//
//  ProfileService.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon

enum ProfileService {
    
    case createInbox(request: CreateInboxRequestModel)
    case follow(request: MemberFollowingRequestModel)
    case getFriends
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
            
        case .getFriends:
            return .get
            
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
        
        case .getFriends:
            return "MemberFollowing/GetFriends"
            
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
        handleResponse(type: responseType, result: result)
    }
}
