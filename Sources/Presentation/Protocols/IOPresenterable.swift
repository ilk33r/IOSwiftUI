//
//  IOPresenterable.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI
import IOSwiftUIInfrastructure

public protocol IOPresenterableInitializer {
    
    func _initializaPresenterable(entity: IOEntity?)
}

public protocol IOPresenterable: ObservableObject {
    
    // MARK: - Generics
    
    associatedtype Environment: IOAppEnvironment
    associatedtype Interactor: IOInteractor
    associatedtype NavigationState: IONavigationState
    
    var environment: EnvironmentObject<Environment>! { get set }
    var interactor: Interactor! { get set }
    var navigationState: StateObject<NavigationState>! { get set }
    
    // MARK: - Initialization Methods
    
    init()
}

public extension IOPresenterable {
    
    func _initializaPresenterable(entity: IOEntity?) {
        self.interactor = Interactor(entityInstance: entity, presenterInstance: self)
    }
    
    // MARK: - Alert
    
    func showAlert(handler: () -> IOAlertData) {
        let alertData = handler()
        self.environment.wrappedValue.alertData = IOAlertData(
            title: alertData.title,
            message: alertData.message,
            buttons: alertData.buttons,
            handler: { [weak self] index in
                self?.environment.wrappedValue.alertData = nil
                alertData.handler?(index)
            }
        )
    }
}
