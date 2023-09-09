// 
//  FriendsMapView.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.06.2023.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import MapKit
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct FriendsMapView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = FriendsMapPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: FriendsMapPresenter
    @StateObject public var navigationState = FriendsMapNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var annotations = [FriendMapPinUIModel]()
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
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                Map(
                    coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking,
                    annotationItems: annotations
                ) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        FriendMapAnnotationView(uiModel: place)
                    }
                }
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .title,
                    iconName: "person.3.fill",
                    hasBackButton: true
                )
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            FriendsMapNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                presenter.prepareForPreview()
                presenter.prepare()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            Task {
                await presenter.loadUserLocation()
            }
            
            presenter.prepare()
        }
        .onReceive(presenter.$userLocation) { location in
            guard let location else { return }
            region.center = location.coordinate
        }
        .onReceive(presenter.$annotations) { output in
            annotations = output
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct FriendsMapView_Previews: PreviewProvider {
    
    struct FriendsMapViewDemo: View {
        
        var body: some View {
            FriendsMapView(
                entity: FriendsMapEntity(
                    friends: FriendsPreviewData.previewDataView()
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return FriendsMapViewDemo()
    }
}
#endif
