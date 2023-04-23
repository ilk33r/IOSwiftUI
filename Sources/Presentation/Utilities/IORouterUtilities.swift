//
//  IORouterUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import SwiftUI

public struct IORouterUtilities {
    
    // MARK: - Router Methods
    
    public static func route<Router: IOBaseRouterDefinition>(_ router: Router.Type, _ type: Router) -> IORouterView {
        Self.route(type)
    }
    
    public static func route(_ type: any IOBaseRouterDefinition) -> IORouterView {
        let appRouter = appRouter()
        let view = appRouter._instance(controllerName: type.viewName, entity: type.entity)
        return IORouterView(view)
    }
    
    // MARK: - Helper Methods
    
    private static func appRouter() -> IORouterProtocol.Type {
        guard let appRouter = NSClassFromString("AppRouter") as? IORouterProtocol.Type else {
            fatalError("Could not found AppRouter class")
        }
        
        return appRouter
    }
}
