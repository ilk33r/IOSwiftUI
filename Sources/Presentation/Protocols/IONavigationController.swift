//
//  IONavigationController.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public protocol IONavigationController: View {
    
    // MARK: - Generics
    
    associatedtype Presenter: IOPresenterable
    associatedtype ControllerBody: View
    associatedtype Wireframe: IONavigationLinkView
    
    // MARK: - Properties
    
    var presenter: Presenter { get set }
    @ViewBuilder var controllerBody: Self.ControllerBody { get }
    
    var wireframeView: Wireframe { get }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter)
    init(entity: Presenter.Interactor.Entity)
}

public extension IONavigationController {
    
    var body: some View {
        NavigationView {
            VStack {
                self.controllerBody
                self.wireframeView
            }
        }
    }
    
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
