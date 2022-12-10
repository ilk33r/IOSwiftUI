// 
//  DiscoverView.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct DiscoverView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = DiscoverPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: DiscoverPresenter
    @StateObject public var navigationState = DiscoverNavigationState()
    
    @State private var contentSize: CGSize = .zero
    @State private var isRefreshing = false
    @State private var scrollOffset: CGFloat = 0
    @State private var screenHeight: CGFloat = 0
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    public var body: some View {
        GeometryReader { proxy in
            IORefreshableScrollView(
                backgroundColor: .white,
                contentSize: $contentSize,
                isRefreshing: $isRefreshing,
                scrollOffset: $scrollOffset
            ) { _ in
                LazyVStack {
                    ForEach(presenter.images) { item in
                        DiscoverCellView(
                            uiModel: item,
                            width: proxy.size.width
                        ) { userName in
                            navigationState.userName = userName
                            navigationState.navigateToProfile = true
                        }
                    }
                }
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
                .onAppear {
                    let safeareaTop = proxy.safeAreaInsets.top
                    let safeareaBottom = proxy.safeAreaInsets.bottom
                    screenHeight = proxy.size.height + safeareaTop + safeareaBottom
                }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(type: .discoverTitle)
        .navigationWireframe {
            DiscoverNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
                presenter.loadImages(showIndicator: true)
            }
            
            navigationState.userName = nil
            navigationState.navigateToProfile = false
        }
        .onChange(of: isRefreshing) { _ in
            if isRefreshing {
                presenter.resetPaging()
                presenter.loadImages(showIndicator: false)
            }
        }
        .onChange(of: scrollOffset) { newValue in
            if newValue + screenHeight >= contentSize.height {
                presenter.loadImages(showIndicator: false)
            }
        }
        .onReceive(presenter.$isRefreshing) { newValue in
            if !(newValue ?? false) {
                isRefreshing = false
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct DiscoverView_Previews: PreviewProvider {
    
    struct DiscoverViewDemo: View {
        
        let uiModels = [
            DiscoverUIModel(
                imagePublicId: "pwGallery0",
                userName: "ilker",
                userNameAndSurname: "İlker Özcan",
                userAvatarPublicId: "pwProfilePicture",
                messageTime: "1 Hour ago"
            ),
            DiscoverUIModel(
                imagePublicId: "pwGallery1",
                userName: "ilker",
                userNameAndSurname: "İlker Özcan",
                userAvatarPublicId: "pwProfilePicture",
                messageTime: "1 Hour ago"
            ),
            DiscoverUIModel(
                imagePublicId: "pwGallery2",
                userName: "ilker",
                userNameAndSurname: "İlker Özcan",
                userAvatarPublicId: "pwProfilePicture",
                messageTime: "1 Hour ago"
            ),
            DiscoverUIModel(
                imagePublicId: "pwGallery3",
                userName: "ilker",
                userNameAndSurname: "İlker Özcan",
                userAvatarPublicId: "pwProfilePicture",
                messageTime: "1 Hour ago"
            )
        ]
        
        let view = DiscoverView(entity: DiscoverEntity())
        
        var body: some View {
            view
                .onAppear {
//                    view.presenter.images = uiModels
                }
        }
    }
    
    static var previews: some View {
        prepare()
        return DiscoverViewDemo()
    }
}
#endif
