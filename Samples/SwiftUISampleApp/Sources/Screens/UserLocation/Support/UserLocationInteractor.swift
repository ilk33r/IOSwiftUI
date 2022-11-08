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
import MapKit
import SwiftUISampleAppScreensShared

public struct UserLocationInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: UserLocationEntity!
    public weak var presenter: UserLocationPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<UserLocationService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func geocodeLocation(userLocation: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { placemarks, error in
            if let error {
                showAlert(error.localizedDescription, handler: nil)
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
                
                presenter?.update(location: userLocation, locationName: locationName)
            }
        }
    }
}
