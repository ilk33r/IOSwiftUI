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
    @State private var scrollContentSize: CGSize = .zero
    @State private var scrollOffset: CGFloat = 0
    @State private var tapIndex: Int = -1
    @State private var viewSize: CGSize = .zero
    @State private var galleryView: GalleryView?
    @State private var screenHeight: CGFloat = 0
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                let headerHeight = max(0, headerSize.height - scrollOffset)
                ZStack(alignment: .top) {
                    ProfileHeaderView(
                        uiModel: $presenter.profileUIModel
                    ) { buttonType in
                        switch buttonType {
                        case .friends:
                            Task {
                                await presenter.navigateToFriends()
                            }
                            
                        case .settings:
                            presenter.navigateToSettings()
                            
                        case .follow:
                            Task {
                                await presenter.followMember()
                            }
                            
                        case .unfollow:
                            Task {
                                await presenter.unFollowMember()
                            }
                            
                        case .message:
                            presenter.createInbox()
                            
                        case .location:
                            presenter.navigateToLocation(isPresented: $navigationState.navigateToMap)
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
                
                if let galleryView {
                    galleryView
                        .zIndex(10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
                .onAppear {
                    let safeareaTop = proxy.safeAreaInsets.top
                    let safeareaBottom = proxy.safeAreaInsets.bottom
                    screenHeight = proxy.size.height + safeareaTop + safeareaBottom
                }
        }
        .onChange(of: tapIndex) { newValue in
            navigationState.galleryEntity = PhotoGalleryEntity(
                imagePublicIds: presenter.images,
                isPresented: $navigationState.navigateToGallery,
                selectedIndex: newValue
            )
            navigationState.galleryView = IORouterUtilities.route(GalleryRouters.self, .gallery(entity: navigationState.galleryEntity))
            navigationState.navigateToGallery = true
        }
        .onChange(of: scrollOffset) { newValue in
            if isPreviewMode {
                return
            }
            
            if newValue + screenHeight >= scrollContentSize.height - headerSize.height {
                Task {
                    await presenter.loadImages()
                }
            }
        }
        .navigationWireframe(hasNavigationView: true, isHidden: navigationBarHidden) {
            ProfileNavigationWireframe(navigationState: navigationState)
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            if isPreviewMode {
                presenter.prepareForPreview()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            Task {
                await presenter.prepare()
            }
            
            Task {
                await presenter.loadImages()
            }
        }
        .onReceive(presenter.$chatEntity) { chatEntity in
            if chatEntity == nil {
                return
            }
            navigationBarHidden = true
            navigationState.chatEntity = chatEntity
            navigationState.navigateToChat = true
        }
        .onReceive(presenter.$navigationBarHidden) { output in
            navigationBarHidden = output
        }
        .onReceive(presenter.profilePictureUpdatedPublisher) { output in
            if output ?? false {
                Task {
                    await presenter.prepare()
                }
            }
        }
        .onReceive(presenter.$images) { output in
            galleryView = GalleryView(
                insetTop: $headerSize.height,
                scrollContentSize: $scrollContentSize,
                scrollOffset: $scrollOffset,
                tapIndex: $tapIndex,
                viewSize: $viewSize,
                galleryImages: output ?? []
            )
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    
    struct ProfileViewDemo: View {
        
        var body: some View {
            ProfileView(
                entity: ProfilePreviewData.previewData
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ProfileViewDemo()
    }
}
#endif
