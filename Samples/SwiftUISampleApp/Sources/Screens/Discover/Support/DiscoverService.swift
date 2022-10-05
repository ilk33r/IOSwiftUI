//
//  DiscoverService.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.10.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

enum DiscoverService {
    
    case discover(request: PaginationRequestModel)
}

extension DiscoverService: IOServiceType {
    
    var methodType: IOHTTPRequestType {
        switch self {
        case .discover:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .discover:
            return "Discover/Discover"
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
        case .discover(request: let request):
            return self.handleRequest(request)
        }
    }
    
    func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        return self.handleResponse(type: responseType, result: result)
    }
}
