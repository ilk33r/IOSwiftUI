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
