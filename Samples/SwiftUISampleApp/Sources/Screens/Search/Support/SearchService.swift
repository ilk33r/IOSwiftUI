// 
//  SearchService.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation

enum SearchService {

    case discoverAll(request: PaginationRequestModel)
    case discoverMember(request: DiscoverSearchMemberRequestModel)
}

extension SearchService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .discoverAll:
            return .post
            
        case .discoverMember:
            return .post
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
        case .discoverAll:
            return "Discover/DiscoverAll"
            
        case .discoverMember:
            return "Discover/DiscoverMemberImages"
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
        case .discoverAll(request: let request):
            return handleRequest(request)
            
        case .discoverMember(request: let request):
            return handleRequest(request)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return handleResponse(type: responseType, result: result)
    }
}
