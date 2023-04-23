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
    @State private var isKeyboardVisible = false
    @State private var isRefreshing = false
    @State private var searchText = ""
    @State private var scrollOffset: CGFloat = 0
    @State private var screenHeight: CGFloat = 0
    
    // MARK: - Body
    
    public var body: some View {
        EmptyView()
        /*
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOObservableScrollView(
                    contentSize: $contentSize,
                    scrollOffset: $scrollOffset
                ) { _ in
                    Text(type: .searchResultTypeAll)
                        .font(type: .black(13))
                        .foregroundColor(.black)
                        .padding(.top, 32)
                        .frame(width: proxy.size.width - 32, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    let itemSize = ((proxy.size.width - 32) / 3) - 8
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(itemSize), spacing: 11),
                            GridItem(.fixed(itemSize), spacing: 11),
                            GridItem(.fixed(itemSize), spacing: 0)
                        ]
                    ) {
                        ForEach(presenter.images) { item in
                            SearchCellView(
                                imageWidth: itemSize,
                                uiModel: item
                            ) { userName in
                                navigationState.userName = userName
                                
                                if isKeyboardVisible {
                                    UIResponder.hideKeyboard()
                                    return
                                }
                                
                                navigationState.navigateToProfile = true
                            }
                            .shimmering(active: item.isDummy)
                        }
                    }
                    .padding(.vertical, 24)
                }
                .hideKeyboardOnTap()
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
                    .onAppear {
                        let safeareaTop = proxy.safeAreaInsets.top
                        let safeareaBottom = proxy.safeAreaInsets.bottom
                        screenHeight = proxy.size.height + safeareaTop + safeareaBottom
                    }
            }
            .navigationBar {
                SearchNavBar(
                    text: $searchText
                ) {
                    searchText = searchText.trimNonAlphaNumericCharacters()
                    presenter.searchUser(userName: searchText)
                }
            }
        }
        .navigationWireframe {
            SearchNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                presenter.preparePreviewData()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.loadImages()
            
            navigationState.userName = nil
            navigationState.navigateToProfile = false
        }
        .onChange(of: isRefreshing) { _ in
            if isRefreshing {
                searchText = ""
                presenter.resetPaging()
                presenter.loadImages()
            }
        }
        .onChange(of: scrollOffset) { newValue in
            if newValue + screenHeight >= contentSize.height {
                presenter.loadImages()
            }
        }
        .onReceive(presenter.$isRefreshing) { newValue in
            if !(newValue ?? false) {
                isRefreshing = false
            }
        }
        .onReceive(presenter.keyboardPublisher) { output in
            isKeyboardVisible = output
            
            if !output && navigationState.userName != nil {
                navigationState.navigateToProfile = true
            }
        }
        .onChange(of: searchText) { newValue in
            searchText = newValue.trimNonAlphaNumericCharacters()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return SearchView(entity: SearchEntity())
    }
}
#endif
