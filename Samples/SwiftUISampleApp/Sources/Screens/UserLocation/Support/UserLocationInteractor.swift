// 
//  UserLocationInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUISupportLocation
import MapKit
import SwiftUISampleAppScreensShared

public struct UserLocationInteractor: IOInteractor {
    
    // MARK: - Defs
    
    enum InteractorError: Error {
        
        case geocodeError(message: String)
        case navigateToSettings(message: IOLocalizationType, settingsURL: URL?)
    }
    
    // MARK: - Interactorable
    
    public var entity: UserLocationEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private let location: IOLocation
    private var service = IOServiceProviderImpl<UserLocationService>()
    
    // MARK: - Initialization Methods
    
    public init() {
        self.location = IOLocation()
    }
    
    // MARK: - Interactor
    
    @MainActor
    func loadUserLocation() async throws -> CLLocation? {
        if !entity.isEditable {
            return CLLocation(
                latitude: entity.locationLatitude.wrappedValue ?? 0,
                longitude: entity.locationLongitude.wrappedValue ?? 0
            )
        }
        
        return try await withUnsafeThrowingContinuation { contination in
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
    
    @MainActor
    func geocodeLocation(userLocation: CLLocation) async throws -> String {
        showIndicator()
        
        return try await withUnsafeThrowingContinuation { contination in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(userLocation) { placemarks, error in
                if let error {
                    hideIndicator()
                    contination.resume(throwing: InteractorError.geocodeError(message: error.localizedDescription))
                    return
                }
                
                if let placemark = placemarks?.first {
                    let countryName = placemark.country ?? ""
                    let stateName = placemark.administrativeArea ?? ""
                    let localityName = placemark.locality ?? ""
                    
                    var locationName = ""
                    if !localityName.isEmpty {
                        locationName += localityName
                    }
                    
                    if !stateName.isEmpty {
                        if !locationName.isEmpty {
                            locationName += ", "
                        }
                        locationName += stateName
                    }
                    
                    if !countryName.isEmpty {
                        if !locationName.isEmpty {
                            locationName += ", "
                        }
                        locationName += countryName
                    }
                    
                    hideIndicator()
                    contination.resume(returning: localityName)
                    return
                }
                
                hideIndicator()
                contination.resume(throwing: IOInteractorError.service)
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
