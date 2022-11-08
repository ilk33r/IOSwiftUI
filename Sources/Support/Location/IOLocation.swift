//
//  IOLocation.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import CoreLocation
import Foundation
import IOSwiftUIInfrastructure
import UIKit

final public class IOLocation: NSObject {
    
    // MARK: - Defs
    
    public typealias AuthorizationHandler = (
        _ authorizationStatus: CLAuthorizationStatus?,
        _ errorMessage: IOLocalizationType?,
        _ settingsURL: URL?
    ) -> Void
    public typealias GeofenceHandler = (_ isEnter: Bool, _ region: CLCircularRegion?) -> Void
    
    // MARK: - Publics
    
    public var isGeofenceSupports: Bool {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            return true
        }
        
        return false
    }
    
    // MARK: - Constants
    
    private let locationAppPrefGeneral = "General"
    private let locationAppPrefLocationServices = "Privacy&path=LOCATION_SERVICES"
    private let locationAppPrefLocationPrivacy = "Privacy&path=LOCATION/%@"
    
    // MARK: - Privates
    
    private var currentLocationRequestId: IOLocationRequest.ID
    private var isAuthorized: Bool?
    private var locationManager: CLLocationManager!
    private var subscribers: [ IOLocationRequest.ID: IOLocationRequest ]
    private var authorizationStatusHandler: AuthorizationHandler?
    private var geofenceListenerHandler: GeofenceHandler?
    
    // MARK: - DI
    
    @IOInject private var appState: IOAppStateImpl
    @IOInstance private var thread: IOThreadImpl
    
    // MARK: - Initialization Methods
    
    public override init() {
        self.currentLocationRequestId = 0
        self.locationManager = CLLocationManager()
        self.subscribers = [:]
        super.init()
        
        self.locationManager.delegate = self
    }
    
    deinit {
        self.locationManager.delegate = nil
        self.locationManager = nil
    }
    
    // MARK: - Setters
    
    public func setGeofenceListenerHandler(_ handler: GeofenceHandler?) {
        self.geofenceListenerHandler = handler
    }
    
    // MARK: - Location Utilities Methods
    
    public func authorizeAlways(_ handler: AuthorizationHandler?) {
        // Authorize location services
        self.authorizationStatusHandler = handler
        
        self.thread.runOnBackgroundThread { [weak self] in
            self?.authorize(isAlways: true)
        }
    }
    
    public func authorizeWhenInUse(_ handler: AuthorizationHandler?) {
        // Authorize location services
        self.authorizationStatusHandler = handler
        
        self.thread.runOnBackgroundThread { [weak self] in
            self?.authorize(isAlways: false)
        }
    }
    
    // MARK: - Geofence Methods
    
    public func registerForGeofence(region: CLCircularRegion) {
        // Check geofence is supporting
        guard let isAuthorized = self.isAuthorized else {
            fatalError("IOLocation: Authorize location manager firstly.")
        }
        
        if !self.isGeofenceSupports {
            // Do nothing
            return
        } else if !isAuthorized {
            // Do nothing
            return
        }
        
        // Region is monitoring
        var isMonitoring = false
        
        // Loop throught monitoring regions
        for geotification in self.locationManager.monitoredRegions where geotification.identifier == region.identifier {
            // Update monitoring status
            isMonitoring = true
        }
        
        // Check region is monitoring
        if !isMonitoring {
            // Start monitoring
            self.locationManager.startMonitoring(for: region)
        }
    }
    
    public func unRegisterForGeofence(region: CLCircularRegion) {
        // Loop throught monitoring regions
        for geotification in self.locationManager.monitoredRegions where geotification.identifier == region.identifier {
            // Stop monitoring
            self.locationManager.stopMonitoring(for: geotification)
        }
    }
    
    // MARK: - Location Methods
    
    public func cancelAllLocationRequests() {
        // Update subscribers
        self.subscribers = [:]
        
        // Stop tracking
        self.locationManager.stopUpdatingLocation()
    }
    
    public func cancelLocation(request: IOLocationRequest) {
        // Check request id exists in dictionary
        if self.subscribers[request.requestId] != nil {
            // Remove object
            self.subscribers.removeValue(forKey: request.requestId)
        }
    }
    
    public func cancelSignificantLocationChanges() {
        // Stop significant location changes
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    public func request(_ handler: IOLocationRequest.Handler?) -> IOLocationRequest? {
        // Check is authorized
        guard let isAuthorized = self.isAuthorized else {
            fatalError("IOLocation: Authorize location manager firstly.")
        }
        
        if isAuthorized {
            // Generate request id
            let requestId = self.generateRequestId()
            
            // Create location request
            let request = IOLocationRequest(isSignificant: false, isSingleRequest: true, handler: handler, requestId: requestId)
            
            // Append location request to subscriber list
            self.subscribers[requestId] = request
            
            // Start updating location
            self.locationManager.startUpdatingLocation()
            
            // Do nothing
            return request
        }
        
        // Call handler
        handler?(false, nil)
        return nil
    }
    
    public func subscribeToLocationUpdates(_ handler: IOLocationRequest.Handler?) -> IOLocationRequest? {
        // Check is authorized
        guard let isAuthorized = self.isAuthorized else {
            fatalError("IOLocation: Authorize location manager firstly.")
        }
        
        if isAuthorized {
            // Generate request id
            let requestId = self.generateRequestId()
            
            // Create location request
            let request = IOLocationRequest(isSignificant: false, isSingleRequest: false, handler: handler, requestId: requestId)
            
            // Append location request to subscriber list
            self.subscribers[requestId] = request
            
            // Start updating location
            self.locationManager.startUpdatingLocation()
            
            // Do nothing
            return request
        }
        
        // Call handler
        handler?(false, nil)
        return nil
    }
    
    public func subscribeToSignificantLocationChanges(_ handler: IOLocationRequest.Handler?) -> IOLocationRequest? {
        // Check is authorized
        guard let isAuthorized = self.isAuthorized else {
            fatalError("IOLocation: Authorize location manager firstly.")
        }
        
        if isAuthorized {
            // Generate request id
            let requestId = self.generateRequestId()
            
            // Create location request
            let request = IOLocationRequest(isSignificant: true, isSingleRequest: false, handler: handler, requestId: requestId)
            
            // Append location request to subscriber list
            self.subscribers[requestId] = request
            
            // Start significant location changes
            self.locationManager.startMonitoringSignificantLocationChanges()
            
            // Do nothing
            return request
        }
        
        // Call handler
        handler?(false, nil)
        return nil
    }
}

extension IOLocation: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.thread.runOnMainThread { [weak self] in
            self?.sendAuthorizationStatus(status: status)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.geofenceListenerHandler?(true, region as? CLCircularRegion)
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.geofenceListenerHandler?(false, region as? CLCircularRegion)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Check subscriber list is empty
        if self.subscribers.isEmpty {
            // Stop tracking
            self.locationManager.stopUpdatingLocation()
            
            // Do nothing
            return
        }
        
        // Loop throught subscribers
        for (requestId, request) in self.subscribers {
            // Call handler
            request.handler?(true, locations.last)
            
            // Check request is single request
            if !request.isSignificant && request.isSingleRequest {
                // Remove object
                self.subscribers.removeValue(forKey: requestId)
            }
        }
    }
}

extension IOLocation {
    
    // MARK: - Authorization
    
    private func authorize(isAlways: Bool) {
        // Obtain authorization status
        let authorizationStatus = self.locationManager.authorizationStatus
        
        if authorizationStatus == .notDetermined {
            // Request always authorization
            if isAlways {
                self.locationManager.requestAlwaysAuthorization()
            } else {
                self.locationManager.requestWhenInUseAuthorization()
            }
            
            return
        }
        
        // Check location services is not enabled
        if !CLLocationManager.locationServicesEnabled() {
            // Show alert
            self.thread.runOnMainThread { [weak self] in
                self?.sendAuthorizationStatus(status: nil)
            }
            return
        }
        
        self.thread.runOnMainThread { [weak self] in
            self?.sendAuthorizationStatus(status: authorizationStatus)
        }
    }
    
    private func generateRequestId() -> IOLocationRequest.ID {
        // Increase request id
        self.currentLocationRequestId += 1
        return self.currentLocationRequestId
    }
    
    private func generateSettingsURL(path: String) -> URL? {
        let pathWithBundleID: String
        
        if path == self.locationAppPrefLocationPrivacy {
            pathWithBundleID = String(format: path, self.appState.bundleIdentifier)
        } else {
            pathWithBundleID = path
        }
        
        // Redirect to location services
        let preferenceUrlString = String(format: "%@root=%@", UIApplication.openSettingsURLString, pathWithBundleID)
        return URL(string: preferenceUrlString)
    }
    
    private func sendAuthorizationStatus(status: CLAuthorizationStatus?) {
        guard let status else {
            self.isAuthorized = false
            self.authorizationStatusHandler?(nil, .locationServiceDisabledMessage, self.generateSettingsURL(path: self.locationAppPrefLocationServices))
            return
        }
        
        if status == .notDetermined {
            self.isAuthorized = false
            self.authorizationStatusHandler?(status, nil, nil)
        } else if status == .denied {
            self.isAuthorized = false
            self.authorizationStatusHandler?(status, .locationServiceDeniedMessage, self.generateSettingsURL(path: self.locationAppPrefLocationPrivacy))
        } else if status == .restricted {
            self.isAuthorized = false
            self.authorizationStatusHandler?(status, .locationServiceRestrictedMessage, self.generateSettingsURL(path: self.locationAppPrefGeneral))
        }
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.isAuthorized = true
            self.authorizationStatusHandler?(status, nil, nil)
        }
        
        self.authorizationStatusHandler = nil
    }
}
