//
//  IODeepLinkDefinition.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2023.
//

import Foundation
import IOSwiftUIPresentation

public protocol IODeepLinkDefinition {
    
    // MARK: - Properties
    
    var controller: any IOController.Type { get }
    
    // MARK: - Initialization Methods
    
    static func from(components: URLComponents) -> Self?
}

public extension IODeepLinkDefinition {
    
    func route(deepLinkUrlComponents: URLComponents) async throws -> IORouterView {
        let view = try await controller.prefetch(deepLinkUrl: deepLinkUrlComponents)
        return IORouterView(view)
    }
}
