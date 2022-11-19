//
//  HomeRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.10.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum HomeRouters: IORouterDefinition {
    
    case home(entity: HomeEntity?)
    case discover(entity: DiscoverEntity?)
    case chat(entity: ChatEntity?)
    case chatInbox(entity: ChatInboxEntity?)
    case profile(entity: ProfileEntity?)
    case search(entity: SearchEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .home(entity: let entity):
            return entity
            
        case .discover(entity: let entity):
            return entity
        
        case .chat(entity: let entity):
            return entity
            
        case .chatInbox(entity: let entity):
            return entity
            
        case .profile(entity: let entity):
            return entity
            
        case .search(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .home:
            return "HomeView"
            
        case .discover:
            return "DiscoverView"
        
        case .chat:
            return "ChatView"
            
        case .chatInbox:
            return "ChatInboxView"
            
        case .profile:
            return "ProfileView"
            
        case .search:
            return "SearchView"
        }
    }
}
