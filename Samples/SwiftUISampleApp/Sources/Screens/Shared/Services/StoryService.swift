//
//  StoryService.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation
import IOSwiftUIInfrastructure

public enum StoryService {
    
    case discoverStories
}

extension StoryService: IOServiceType {
    
    public var methodType: IOHTTPRequestType {
        switch self {
        case .discoverStories:
            return .get
        }
    }
    
    public var requestContentType: IOServiceContentType {
        switch self {
        default:
            return .applicationJSON
        }
    }
    
    public var path: String {
        switch self {
        case .discoverStories:
            return "Discover/DiscoverStories"
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
        default:
            return nil
        }
    }
    
    public func response<TModel: Codable>(responseType: TModel.Type, result: IOHTTPResult?) -> IOServiceResult<TModel> {
        handleResponse(type: responseType, result: result)
    }
}
