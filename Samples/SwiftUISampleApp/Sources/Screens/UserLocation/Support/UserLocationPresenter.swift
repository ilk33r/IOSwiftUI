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
import UIKit

final public class UserLocationPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: UserLocationInteractor!
    public var navigationState: StateObject<UserLocationNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var addPin: Bool!
    @Published private(set) var userLocation: CLLocation?
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.addPin = false
    }
    
    // MARK: - Presenter
    
    @MainActor
    func loadUserLocation() async {
        do {
            self.userLocation = try await self.interactor.loadUserLocation()
            self.addPin = true
        } catch UserLocationInteractor.InteractorError.navigateToSettings(let message, let settingsURL) {
            await self.navigateToSettings(message: message, settingsURL: settingsURL)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func saveUserLocation(annotations: [UserLocationMapPinUIModel]) async {
        guard let annotation = annotations.first else {
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .errorSelectLocation,
                    buttons: [.commonOk]
                )
            }
            return
        }
        
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        do {
            let locationName = try await self.interactor.geocodeLocation(userLocation: location)
            
            self.interactor.entity.locationName.wrappedValue = locationName
            self.interactor.entity.locationLatitude.wrappedValue = location.coordinate.latitude
            self.interactor.entity.locationLongitude.wrappedValue = location.coordinate.longitude
            self.interactor.entity.isPresented.wrappedValue = false
        } catch UserLocationInteractor.InteractorError.geocodeError(message: let message) {
            await showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: message,
                    buttons: [.commonOk]
                )
            }
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func navigateToSettings(message: IOLocalizationType, settingsURL: URL?) async {
        let index = await self.showAlertAsync {
            IOAlertData(
                title: nil,
                message: message,
                buttons: [.commonCancel, .commonOk]
            )
        }
        
        if index == 1, let settingsURL {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
