// 
//  SearchView.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct SearchView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SearchPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SearchPresenter
    @StateObject public var navigationState = SearchNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var contentSize: CGSize = .zero
    @State private var isRefreshing = false
    @State private var searchText = ""
    @State private var scrollOffset: CGFloat = 0
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IORefreshableScrollView(
                    backgroundColor: .white,
                    contentSize: $contentSize,
                    isRefreshing: $isRefreshing,
                    scrollOffset: $scrollOffset
                ) { _ in
                    LazyVStack {
                        ForEach(presenter.images) { _ in // item in
//                            DiscoverCellView(
//                                uiModel: item,
//                                width: proxy.size.width
//                            ) { _ in // userName in
////                                navigationState.userName = userName
////                                navigationState.navigateToProfile = true
//                            }
                        }
                    }
                }
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .navigationBar {
                SearchNavBar(
                    text: $searchText
                ) {
                    IOLogger.debug("Editing end")
                }
            }
        }
        .navigationWireframe {
            SearchNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
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
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return SearchView(entity: SearchEntity())
    }
}
