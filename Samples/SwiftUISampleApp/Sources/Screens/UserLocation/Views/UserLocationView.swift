// 
//  UserLocationView.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.11.2022.
//

import CoreLocation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import MapKit
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct UserLocationView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = UserLocationPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: UserLocationPresenter
    @StateObject public var navigationState = UserLocationNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @Binding private var isPresented: Bool
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    @State private var tracking: MapUserTrackingMode = .follow
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            Map(
                coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $tracking
            )
            .navigationBar {
                HStack {
                    Text(type: .userLocationSelectLocationTitle)
                        .font(type: .systemSemibold(17))
                        .multilineTextAlignment(.center)
                        .padding(.leading, 64)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    IOButton(.commonSave)
                        .font(type: .regular(16))
                        .foregroundColor(.colorTabEnd)
                        .frame(width: 64)
                        .setClick {
                            
                        }
                }
            }
        }
        .navigationWireframe {
            UserLocationNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
                presenter.loadUserLocation()
            }
        }
        .alert(isPresented: $appEnvironment.showAlert) {
            return Alert(
                title: Text(appEnvironment.alertTitle),
                message: Text(appEnvironment.alertMessage),
                primaryButton: .default(
                    Text(appEnvironment.alertButtons[0].localized),
                    action: {
                        appEnvironment.alertHandler?(0)
                    }
                ),
                secondaryButton: .destructive(
                    Text(appEnvironment.alertButtons[1].localized),
                    action: {
                        appEnvironment.alertHandler?(1)
                    }
                )
            )
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
        self._isPresented = presenter.interactor.entity.isPresented
    }
}

struct UserLocationView_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationView(
            entity: UserLocationEntity(
                isPresented: Binding.constant(false)
            )
        )
    }
}
