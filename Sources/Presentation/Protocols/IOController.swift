//
//  IOController.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public protocol IOController: View {
    
    // MARK: - Generics
    
    associatedtype Presenter: IOPresenterable
    
    // MARK: - Properties
    
    var presenter: Self.Presenter { get set }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter)
    init(entity: Presenter.Interactor.Entity)
}

public extension IOController {
    
    init(presenter: Presenter) {
        self.init(presenter: presenter)
    }
    
    init(entity: Presenter.Interactor.Entity) {
        // swiftlint:disable explicit_init
        let presenter = Presenter.init()
        presenter._initializaPresenterable(entity: entity)
        
        self.init(presenter: presenter)
        // swiftlint:enable explicit_init
    }
}
