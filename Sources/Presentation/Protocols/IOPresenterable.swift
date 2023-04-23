//
//  IOPresenterable.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

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
    
    func dismissPicker() {
        self.environment.wrappedValue.datePickerData = nil
        self.environment.wrappedValue.pickerData = nil
    }
    
    @available(*, deprecated, message: "use show alert async")
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
    
    @discardableResult
    @MainActor
    func showAlertAsync(handler: () -> IOAlertData) async -> Int {
        do {
            return try await withUnsafeThrowingContinuation { [weak self] contination in
                let alertData = handler()
                self?.environment.wrappedValue.alertData = IOAlertData(
                    title: alertData.title,
                    message: alertData.message,
                    buttons: alertData.buttons,
                    handler: { [weak self] index in
                        self?.environment.wrappedValue.alertData = nil
                        contination.resume(returning: index)
                    }
                )
            }
        } catch {
            return 0
        }
    }
    
    func showDatePicker(handler: () -> IODatePickerData) {
        self.environment.wrappedValue.datePickerData = handler()
    }
    
    func showPicker(handler: () -> IOPickerData) {
        self.environment.wrappedValue.pickerData = handler()
    }
}
