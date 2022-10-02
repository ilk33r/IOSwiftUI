// 
//  ProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppComponents
import SwiftUISampleAppPresentation

struct ProfileView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ProfilePresenter
    @StateObject public var navigationState = ProfileNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var headerSize: CGSize = .zero
    @State private var scrollOffset: CGFloat = 0
    @State private var tapIndex: Int = -1
    
    let galleryImages = [
        Image("pwGallery0"),
        Image("pwGallery1"),
        Image("pwGallery2"),
        Image("pwGallery3"),
        Image("pwGallery4"),
        Image("pwGallery5"),
        Image("pwGallery0"),
        Image("pwGallery1"),
        Image("pwGallery2"),
        Image("pwGallery3"),
        Image("pwGallery4"),
        Image("pwGallery5"),
        Image("pwGallery0"),
        Image("pwGallery1"),
        Image("pwGallery2"),
        Image("pwGallery3"),
        Image("pwGallery4"),
        Image("pwGallery5")
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                let headerHeight = max(0, headerSize.height - scrollOffset)
                ZStack(alignment: .top) {
                    createHeaderView(member: presenter.member)
                }
                .zIndex(20)
                .frame(height: headerHeight, alignment: .top)
                .clipped()
                GalleryView(
                    insetTop: $headerSize.height,
                    scrollOffset: $scrollOffset,
                    tapIndex: $tapIndex,
                    galleryImages: galleryImages
                )
                .zIndex(10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .onChange(of: tapIndex) { _ in
            navigationState.entity = PhotoGalleryEntity(images: galleryImages)
            navigationState.navigateToGallery = true
        }
        .navigationWireframe(isHidden: true) {
            ProfileNavigationWireframe(navigationState: navigationState)
        }
        .fullScreenCover(isPresented: $navigationState.navigateToGallery) {
            PhotoGalleryView(
                isPresented: $navigationState.navigateToGallery,
                entity: navigationState.entity
            )
        }
        .onAppear {
            if !self.isPreviewMode {
                self.presenter.environment = _appEnvironment
                self.presenter.interactor.getMember()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    // MARK: - Helper Methods
    
    private func createHeaderView(member: MemberModel?) -> some View {
        return ProfileHeaderView(member: member, profilePictureData: self.presenter.profilePictureData)
            .padding(.top, 32)
            .padding(.bottom, 4)
            .background(
                GeometryReader { proxy in
                    Color.clear.onAppear {
                        headerSize = proxy.size
                    }
                }
            )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(entity: ProfileEntity(userName: nil))
    }
}
