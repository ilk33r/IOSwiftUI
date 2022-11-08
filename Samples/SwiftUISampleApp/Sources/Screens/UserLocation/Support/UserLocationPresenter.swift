// 
//  UserLocationPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import CoreLocation
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import IOSwiftUISupportLocation
import UIKit

final public class UserLocationPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: UserLocationInteractor!
    public var navigationState: StateObject<UserLocationNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var userLocation: CLLocation?
    
    // MARK: - Privates
    
    private let location: IOLocation
    
    // MARK: - Initialization Methods
    
    public init() {
        self.location = IOLocation()
    }
    
    // MARK: - Presenter
    
    func loadUserLocation() {
        self.location.authorizeWhenInUse { [weak self] authorizationStatus, errorMessage, settingsURL in
            if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
                self?.requestLocation()
                return
            }
            
            if let message = errorMessage {
                self?.navigateToSettings(message: message, settingsURL: settingsURL)
            }
        }
    }
    
    func saveUserLocation(annotations: [UserLocationMapPinUIModel]) {
        guard let annotation = annotations.first else {
            self.showAlert(IOLocalizationType.userLocationErrorSelectLocation.localized, handler: nil)
            return
        }
        
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        self.interactor.geocodeLocation(userLocation: location)
    }
    
    func update(location: CLLocation, locationName: String) {
        self.interactor.entity.locationName.wrappedValue = locationName
        self.interactor.entity.locationLatitude.wrappedValue = location.coordinate.latitude
        self.interactor.entity.locationLongitude.wrappedValue = location.coordinate.longitude
        self.interactor.entity.isPresented.wrappedValue = false
    }
    
    // MARK: - Helper Methods
    
    private func requestLocation() {
        _ = location.request { [weak self] status, currentLocation in
            if status {
                self?.userLocation = currentLocation
            }
        }
    }
    
    private func navigateToSettings(message: IOLocalizationType, settingsURL: URL?) {
        self.showAlert(
            message.localized,
            buttonTitles: [.commonCancel, .commonOk],
            handler: { index in
                if index == 1, let settingsURL {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
        )
    }
}
