//
//  IOController.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public protocol IOController: View {
    
    // MARK: - Generics
    
    associatedtype Presenter: IOPresenterable
    
    // MARK: - Properties
    
    var isPreviewMode: Bool { get }
    var presenter: Self.Presenter { get set }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter)
    init(entity: IOEntity?)
    
    // MARK: - Prefetch
    
    static func prefetch(deepLinkUrl: URLComponents) async throws -> Self
}

public extension IOController {
    
    // MARK: - Properties
    
    var isPreviewMode: Bool {
        ProcessInfo.isPreviewMode
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.init(presenter: presenter)
    }
    
    init(entity: IOEntity?) {
        // swiftlint:disable explicit_init
        let presenter = Presenter.init()
        presenter._initializaPresenterable(entity: entity)
        
        self.init(presenter: presenter)
        // swiftlint:enable explicit_init
    }
    
    // MARK: - Prefetch
    
    static func prefetch(deepLinkUrl: URLComponents) async throws -> Self {
        // swiftlint:disable explicit_init
        let presenter = Presenter.init()
        try await presenter._prefetchAndInitializaPresenterable(deepLinkUrl: deepLinkUrl)
        
        return self.init(presenter: presenter)
        // swiftlint:enable explicit_init
    }
}
