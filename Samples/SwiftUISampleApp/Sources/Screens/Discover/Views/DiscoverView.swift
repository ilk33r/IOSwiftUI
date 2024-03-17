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
                VStack {
                    if presenter.stories == nil || !(presenter.stories?.isEmpty ?? true) {
                        StoryListView(
                            uiModels: $presenter.stories,
                            handler: { id in
                                presenter.navigateToStories(
                                    pageId: id,
                                    isPresented: $navigationState.navigateToStories
                                )
                            }
                        )
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 8)
                    }
                    
                    LazyVStack {
                        ForEach(presenter.images) { item in
                            DiscoverCellView(
                                uiModel: item,
                                width: proxy.size.width
                            ) { userName in
                                navigationState.navigateToProfile(
                                    profileEntity: ProfileEntity(
                                        navigationBarHidden: true,
                                        userName: userName,
                                        fromDeepLink: false,
                                        member: nil
                                    )
                                )
                            } cartHandler: { imagePublicId in
                                presenter.add(toCart: imagePublicId)
                            }
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
        .navigationTitle(type: .title)
        .navigationWireframe(hasNavigationView: true) {
            DiscoverNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                navigationState.navigateToProfile = false
                presenter.prepareForPreview()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            Task {
                await presenter.prepare()
            }
            
            navigationState.navigateToProfile = false
        }
        .onChange(of: isRefreshing) { _ in
            if isPreviewMode {
                return
            }
            
            if isRefreshing {
                presenter.resetPaging()
                
                Task {
                    await presenter.loadImages(showIndicator: false)
                }
            }
        }
        .onChange(of: scrollOffset) { newValue in
            if isPreviewMode {
                return
            }
            
            if newValue + screenHeight >= contentSize.height {
                Task {
                    await presenter.loadImages(showIndicator: false)
                }
            }
        }
        .onReceive(presenter.$isRefreshing) { newValue in
            if isPreviewMode {
                return
            }
            
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
        
        var body: some View {
            DiscoverView(
                entity: DiscoverEntity()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return DiscoverViewDemo()
    }
}
#endif
