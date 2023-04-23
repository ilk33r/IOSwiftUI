// 
//  ChatInboxView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct ChatInboxView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = ChatInboxPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ChatInboxPresenter
    @StateObject public var navigationState = ChatInboxNavigationState()
    
    @State private var contentSize: CGSize = .zero
    @State private var isRefreshing = false
    @State private var scrollOffset: CGFloat = 0
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    public var body: some View {
        EmptyView()
        /*
        GeometryReader { proxy in
            IORefreshableScrollView(
                backgroundColor: .white,
                contentSize: $contentSize,
                isRefreshing: $isRefreshing,
                scrollOffset: $scrollOffset
            ) { _ in
                LazyVStack {
                    ForEach(presenter.inboxes) { inbox in
                        ChatInboxItemView(
                            uiModel: inbox,
                            clickHandler: { index in
                                presenter.getMessages(index: index)
                            },
                            deleteHandler: { index in
                                presenter.deleteInbox(index: index)
                            }
                        )
                    }
                }
            }
            .navigationBar(navigationBar: {
                NavBarTitleView(.chatInboxTitle, iconName: "message")
            })
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .navigationWireframe {
            ChatInboxNavigationWireframe(navigationState: navigationState)
        }
        .onReceive(presenter.$inboxes) { _ in
            if isRefreshing {
                isRefreshing = false
            }
        }
        .onChange(of: isRefreshing) { _ in
            if isRefreshing {
                presenter.interactor.getInboxes(showIndicator: false)
            }
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.interactor.getInboxes(showIndicator: true)
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct ChatInboxView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInboxView(entity: ChatInboxEntity())
    }
}
#endif
