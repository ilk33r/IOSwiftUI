//
//  IONavigationLinkView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI

public protocol IONavigationLinkView: View {
    
    // MARK: - Generics
    
    associatedtype LinkBody: View
    
    // MARK: - Properties
    
    @ViewBuilder var linkBody: Self.LinkBody { get }
    
    // MARK: - Helper Methods
    
    func route(_ type: any IOBaseRouterDefinition) -> AnyView
}

public extension IONavigationLinkView {
    
    var body: some View {
        self.linkBody
    }
    
    // MARK: - Helper Methods
    
    func route(_ type: any IOBaseRouterDefinition) -> AnyView {
        guard let appRouter = NSClassFromString("AppRouter") as? IORouterProtocol.Type else {
            fatalError("Could not found AppRouter class")
        }
        
        return AnyView(appRouter._instance(controllerName: type.viewName, entity: type.entity))
    }
}
