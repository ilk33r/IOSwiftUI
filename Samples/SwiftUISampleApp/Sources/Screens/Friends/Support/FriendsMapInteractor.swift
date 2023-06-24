// 
//  FriendsMapInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.06.2023.
//

import CoreLocation
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUISupportLocation
import SwiftUISampleAppScreensShared

public struct FriendsMapInteractor: IOInteractor {
    
    // MARK: - Defs
    
    enum InteractorError: Error {
        
        case navigateToSettings(message: IOLocalizationType, settingsURL: URL?)
    }
    
    // MARK: - Interactorable
    
    public var entity: FriendsMapEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private let location: IOLocation
    private var service = IOServiceProviderImpl<FriendsService>()
    
    // MARK: - Initialization Methods
    
    public init() {
        self.location = IOLocation()
    }
    
    // MARK: - Interactor
    
    @MainActor
    func loadUserLocation() async throws -> CLLocation? {
        try await withUnsafeThrowingContinuation { contination in
            location.authorizeWhenInUse { authorizationStatus, errorMessage, settingsURL in
                if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
                    Task {
                        let location = await requestLocation()
                        contination.resume(returning: location)
                    }
                    return
                }
                
                if let message = errorMessage {
                    contination.resume(throwing: InteractorError.navigateToSettings(message: message, settingsURL: settingsURL))
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func requestLocation() async -> CLLocation? {
        await withUnsafeContinuation { contination in
            _ = location.request { status, currentLocation in
                if status {
                    contination.resume(returning: currentLocation)
                } else {
                    contination.resume(returning: nil)
                }
            }
        }
    }
}
