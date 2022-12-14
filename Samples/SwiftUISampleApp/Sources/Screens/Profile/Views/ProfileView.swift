// 
//  ProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct ProfileView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = ProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ProfilePresenter
    @StateObject public var navigationState = ProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var headerSize: CGSize = .zero
    @State private var navigationBarHidden = false
    @State private var presentUserLocation = false
    @State private var scrollContentSize: CGSize = .zero
    @State private var scrollOffset: CGFloat = 0
    @State private var tapIndex: Int = -1
    @State private var viewSize: CGSize = .zero
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            IOUIView { lifecycle in
                if lifecycle == .willAppear && navigationBarHidden {
                    navigationBarHidden = false
                }
            } content: {
                ZStack(alignment: .top) {
                    let headerHeight = max(0, headerSize.height - scrollOffset)
                    ZStack(alignment: .top) {
                        ProfileHeaderView(uiModel: presenter.profileUIModel) { buttonType in
                            switch buttonType {
                            case .friends:
                                presenter.interactor.getFriends()
                                
                            case .settings:
                                presenter.navigateToSettings()
                                
                            case .follow:
                                presenter.followMember()
                                
                            case .unfollow:
                                presenter.unFollowMember()
                                
                            case .message:
                                presenter.createInbox()
                                
                            case .location:
                                presenter.navigateToLocation(isPresented: $presentUserLocation)
                            }
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                        .background(
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    headerSize = proxy.size
                                }
                            }
                        )
                    }
                    .zIndex(20)
                    .frame(height: headerHeight, alignment: .top)
                    .clipped()
                    GalleryView(
                        insetTop: $headerSize.height,
                        scrollContentSize: $scrollContentSize,
                        scrollOffset: $scrollOffset,
                        tapIndex: $tapIndex,
                        viewSize: $viewSize,
                        galleryImages: presenter.images
                    )
                    .zIndex(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .onChange(of: tapIndex) { newValue in
            navigationState.galleryEntity = PhotoGalleryEntity(
                imagePublicIds: presenter.images,
                isPresented: $navigationState.navigateToGallery,
                selectedIndex: newValue
            )
            navigationState.navigateToGallery = true
        }
        .onChange(of: scrollOffset) { newValue in
            if scrollContentSize.height - viewSize.height <= newValue {
                presenter.loadImages()
            }
        }
        .navigationWireframe(isHidden: true) {
            ProfileNavigationWireframe(navigationState: navigationState)
        }
        .onReceive(presenter.$chatEntity) { chatEntity in
            if chatEntity == nil {
                return
            }
            navigationBarHidden = true
            navigationState.chatEntity = chatEntity
            navigationState.navigateToChat = true
        }
        .onReceive(presenter.$userLocationEntity) { userLocationEntity in
            if userLocationEntity != nil {
                presentUserLocation = true
            }
        }
        .navigationBarHidden(navigationBarHidden)
        .navigationBarTitle("", displayMode: .inline)
        .fullScreenCover(isPresented: $navigationState.navigateToGallery) {
            IORouterUtilities.route(GalleryRouters.self, .gallery(entity: navigationState.galleryEntity))
        }
        .sheet(isPresented: $presentUserLocation) {
            IORouterUtilities.route(
                ProfileRouters.self,
                .userLocation(
                    entity: presenter.userLocationEntity
                )
            )
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
                presenter.interactor.getMember()
                presenter.loadImages()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        return ProfileView(entity: ProfileEntity(userName: nil))
    }
}
#endif
