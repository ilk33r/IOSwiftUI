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
    
    @State private var annotations = [UserLocationMapPinUIModel]()
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
            GeometryReader { proxy in
                Map(
                    coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking,
                    annotationItems: annotations
                ) { place in
                    MapPin(coordinate: place.coordinate)
                }
                .gesture(
                    LongPressGesture(
                        minimumDuration: 0.15
                    )
                    .sequenced(
                        before:
                            DragGesture(
                                minimumDistance: 0,
                                coordinateSpace: .local
                            )
                    )
                    .onEnded { value in
                        switch value {
                        case .second(true, let drag):
                            updatePinLocation(at: drag?.location ?? .zero, for: proxy.size)
                            
                        default:
                            break
                        }
                    }
                )
                .highPriorityGesture(DragGesture(minimumDistance: 10))
                .navigationBar {
                    HStack {
                        Text(type: presenter.interactor.entity.isEditable ? .userLocationSelectLocationTitle : .userLocationCurrentTitle)
                            .font(type: .medium(17))
                            .multilineTextAlignment(.center)
                            .padding(.leading, 64)
                            .padding(.trailing, presenter.interactor.entity.isEditable ? 0 : 64)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        if presenter.interactor.entity.isEditable {
                            IOButton(.commonSave)
                                .setClick {
                                    presenter.saveUserLocation(annotations: annotations)
                                }
                                .font(type: .regular(16))
                                .foregroundColor(.colorTabEnd)
                                .frame(width: 64)
                        }
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
                
                if
                    let latitude = presenter.interactor.entity.locationLatitude.wrappedValue,
                    let longitude = presenter.interactor.entity.locationLongitude.wrappedValue,
                    latitude != 0 && longitude != 0
                {
                    annotations = [
                        UserLocationMapPinUIModel(
                            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        )
                    ]
                }
            }
        }
        .onReceive(presenter.$userLocation) { location in
            guard let location else { return }
            region.center = location.coordinate
        }
        .onReceive(presenter.$addPin) { addPin in
            if addPin ?? false {
                annotations = [
                    UserLocationMapPinUIModel(
                        coordinate: presenter.userLocation!.coordinate
                    )
                ]
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
        self._isPresented = presenter.interactor.entity.isPresented
    }
    
    // MARK: - Helper Methods
    
    private func updatePinLocation(at point: CGPoint, for mapSize: CGSize) {
        if !presenter.interactor.entity.isEditable {
            return
        }
        
        let lat = region.center.latitude
        let lon = region.center.longitude
        
        let mapCenter = CGPoint(x: mapSize.width / 2, y: mapSize.height / 2)
        
        // X
        let xValue = (point.x - mapCenter.x) / mapCenter.x
        let xSpan = xValue * region.span.longitudeDelta / 2
        
        // Y
        let yValue = (point.y - mapCenter.y) / mapCenter.y
        let ySpan = yValue * region.span.latitudeDelta / 2
        
        annotations = [
            UserLocationMapPinUIModel(
                coordinate: CLLocationCoordinate2D(latitude: lat - ySpan, longitude: lon + xSpan)
            )
        ]
    }
}

#if DEBUG
struct UserLocationView_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationView(
            entity: UserLocationEntity(
                isEditable: true,
                isPresented: Binding.constant(false),
                locationName: Binding.constant(""),
                locationLatitude: Binding.constant(0),
                locationLongitude: Binding.constant(0)
            )
        )
    }
}
#endif
