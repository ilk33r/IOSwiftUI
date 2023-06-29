// 
//  FriendsMapPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.06.2023.
//

import CoreLocation
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class FriendsMapPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: FriendsMapInteractor!
    public var navigationState: StateObject<FriendsMapNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var annotations: [FriendMapPinUIModel]
    @Published private(set) var userLocation: CLLocation?
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.annotations = []
        self.userLocation = nil
    }
    
    // MARK: - Presenter
    
    func prepare() {
        self.annotations = self.interactor.entity.friends.followings?
            .filter { $0.locationLatitude != nil && $0.locationLongitude != nil }
            .map {
                FriendMapPinUIModel(
                    coordinate: CLLocationCoordinate2D(
                        latitude: CLLocationDegrees($0.locationLatitude!),
                        longitude: CLLocationDegrees($0.locationLongitude!)
                    ),
                    nameSurname: $0.userNameAndSurname ?? "",
                    profilePicturePublicId: $0.profilePicturePublicId
                )
            } ?? []
    }
    
    @MainActor
    func loadUserLocation() async {
        do {
            self.userLocation = try await self.interactor.loadUserLocation()
        } catch FriendsMapInteractor.InteractorError.navigateToSettings(let message, let settingsURL) {
            await self.navigateToSettings(message: message, settingsURL: settingsURL)
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

#if DEBUG
extension FriendsMapPresenter {
    
    func prepareForPreview() {
        self.userLocation = CLLocation(
            latitude: 41.06611,
            longitude: 28.71631
        )
    }
}
#endif
