//
//  IORouterView.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.10.2022.
//

import Foundation
import SwiftUI

public struct IORouterView: View {
    
    // MARK: - Publics
    
    public let contentView: AnyView
    
    // MARK: - Privates
    
    private let view: (any IOController)?
    
    // MARK: - Body
    
    public var body: some View {
        contentView
    }
    
    // MARK: - Initialization Methods
    
    public init(_ view: any IOController) {
        self.view = view
        self.contentView = AnyView(view)
    }
    
    private init(_ view: AnyView) {
        self.view = nil
        self.contentView = view
    }
    
    // MARK: - View Methods
    
    public func setEnvironment<Environment: ObservableObject>(_ environment: Environment) -> IORouterView {
        if let view {
            let environmentView = view.environmentObject(environment)
            return IORouterView(AnyView(environmentView))
        }
        
        return self
    }
}
