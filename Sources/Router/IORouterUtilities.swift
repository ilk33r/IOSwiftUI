//
//  IORouterUtilities.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import SwiftUI
import IOSwiftUIPresentation

public struct IORouterUtilities {
    
    public static func route(_ type: any IOBaseRouterDefinition) -> AnyView {
        guard let appRouter = NSClassFromString("AppRouter") as? IORouterProtocol.Type else {
            fatalError("Could not found AppRouter class")
        }
        
        return AnyView(appRouter._instance(controllerName: type.viewName, entity: type.entity))
    }
}
