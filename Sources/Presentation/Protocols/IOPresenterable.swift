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
    func _prefetchAndInitializaPresenterable(deepLinkUrl: URLComponents) async throws
}

public protocol IOPresenterable: ObservableObject, IOPresenterableInitializer {
    
    // MARK: - Generics
    
    associatedtype Environment: IOAppEnvironment
    associatedtype Interactor: IOInteractor
    associatedtype NavigationState: IONavigationState
    
    var environment: EnvironmentObject<Environment>! { get set }
    var interactor: Interactor! { get set }
    var navigationState: StateObject<NavigationState>! { get set }
    
    // MARK: - Initialization Methods
    
    init()
    
    // MARK: - Prefetch
    
    func prefetch(deepLinkUrl: URLComponents) async throws -> IOEntity?
}

public extension IOPresenterable {
    
    // MARK: - Initialization Methods
    
    func _initializaPresenterable(entity: IOEntity?) {
        self.interactor = Interactor(entityInstance: entity, presenterInstance: self)
    }
    
    func _prefetchAndInitializaPresenterable(deepLinkUrl: URLComponents) async throws {
        do {
            self.interactor = Interactor(entityInstance: nil, presenterInstance: self)
            
            let entity = try await prefetch(deepLinkUrl: deepLinkUrl)
            self.interactor = Interactor(entityInstance: entity, presenterInstance: self)
        }
    }
    
    // MARK: - Prefetch
    
    func prefetch(deepLinkUrl: URLComponents) async throws -> IOEntity? {
        nil
    }
    
    // MARK: - Alert
    
    func dismissPicker() {
        self.environment.wrappedValue.datePickerData = nil
        self.environment.wrappedValue.pickerData = nil
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
