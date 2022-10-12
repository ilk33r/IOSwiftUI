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

struct DiscoverView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = DiscoverPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: DiscoverPresenter
    @StateObject public var navigationState = DiscoverNavigationState()
    @State private var contentSize: CGSize = .zero
    @State private var isRefreshing = false
    @State private var scrollOffset: CGFloat = 0
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    var body: some View {
        GeometryReader { proxy in
            IORefreshableScrollView(
                backgroundColor: .white,
                contentSize: $contentSize,
                isRefreshing: $isRefreshing,
                scrollOffset: $scrollOffset
            ) { _ in
                LazyVStack {
                    ForEach(presenter.images) { item in
                        DiscoverCellView(uiModel: item, width: proxy.size.width)
                    }
                }
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Discover")
        .navigationWireframe(wireframeView: {
            DiscoverNavigationWireframe(navigationState: navigationState)
        })
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.loadImages(showIndicator: true)
            }
        }
        .onChange(of: isRefreshing) { _ in
            if isRefreshing {
                presenter.resetPaging()
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
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(entity: DiscoverEntity())
    }
}
