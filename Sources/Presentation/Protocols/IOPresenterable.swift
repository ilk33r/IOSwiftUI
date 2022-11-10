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
    
    func showAlert(
        _ message: String,
        title: String? = nil,
        buttonTitles: [IOLocalizationType] = [.commonOk],
        handler: IOAlertModifierResultHandler?
    ) {
        self.navigationState.wrappedValue.alertData = IOAlertData(
            title: title ?? "",
            message: message,
            buttons: buttonTitles,
            handler: { [weak self] index in
                handler?(index)
                self?.navigationState.wrappedValue.showAlert.send(false)
            }
        )
        
        self.navigationState.wrappedValue.showAlert.send(true)
    }
    
    func showAlert(
        _ type: IOLocalizationType,
        title: String? = nil,
        buttonTitles: [IOLocalizationType] = [.commonOk],
        handler: IOAlertModifierResultHandler?
    ) {
        self.navigationState.wrappedValue.alertData = IOAlertData(
            title: title ?? "",
            message: type.localized,
            buttons: buttonTitles,
            handler: { [weak self] index in
                handler?(index)
                self?.navigationState.wrappedValue.showAlert.send(false)
            }
        )
        
        self.navigationState.wrappedValue.showAlert.send(true)
    }
}
