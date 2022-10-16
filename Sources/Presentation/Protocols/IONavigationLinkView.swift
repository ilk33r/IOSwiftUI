//
//  IONavigationLinkView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI

public protocol IONavigationLinkView: View {
    
    // MARK: - Helper Methods
    
    func route(_ type: any IOBaseRouterDefinition) -> IORouterView
}

public extension IONavigationLinkView {
    
    // MARK: - Router Methods
    
    func route<Router: IOBaseRouterDefinition>(_ router: Router.Type, _ type: Router) -> IORouterView {
        return self.route(type)
    }
    
    func route(_ type: any IOBaseRouterDefinition) -> IORouterView {
        return IORouterUtilities.route(type)
    }
}
