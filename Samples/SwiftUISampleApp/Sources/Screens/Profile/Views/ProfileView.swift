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

struct ProfileView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ProfilePresenter
    @StateObject public var navigationState = ProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var headerSize: CGSize = .zero
    @State private var scrollContentSize: CGSize = .zero
    @State private var scrollOffset: CGFloat = 0
    @State private var tapIndex: Int = -1
    @State private var viewSize: CGSize = .zero
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                let headerHeight = max(0, headerSize.height - scrollOffset)
                ZStack(alignment: .top) {
                    ProfileHeaderView(uiModel: presenter.profileUIModel) { buttonType in
                        switch buttonType {
                        case .message:
                            presenter.interactor.createInbox()
                            
                        default:
                            break
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
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .onChange(of: tapIndex) { newValue in
            navigationState.entity = PhotoGalleryEntity(
                imagePublicIds: presenter.images,
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
        .navigationBarTitle("", displayMode: .inline)
        .fullScreenCover(isPresented: $navigationState.navigateToGallery) {
            PhotoGalleryView(
                isPresented: $navigationState.navigateToGallery,
                entity: navigationState.entity
            )
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.interactor.getMember()
                presenter.loadImages()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(entity: ProfileEntity(userName: nil))
    }
}
