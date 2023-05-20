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
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
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
                                    Task {
                                        await presenter.getMessages(index: index)
                                    }
                                },
                                deleteHandler: { index in
                                    Task {
                                        await presenter.deleteInbox(index: index)
                                    }
                                }
                            )
                        }
                    }
                }
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(.title, iconName: "message")
            }
        }
        .navigationWireframe(hasNavigationView: true) {
            ChatInboxNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            Task {
                await presenter.prepare()
            }
        }
        .onReceive(presenter.$inboxes) { _ in
            if isRefreshing {
                isRefreshing = false
            }
        }
        .onChange(of: isRefreshing) { _ in
            if isRefreshing {
                Task {
                    await presenter.getInboxes()
                }
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct ChatInboxView_Previews: PreviewProvider {
    
    struct ChatInboxViewDemo: View {
        
        var body: some View {
            ChatInboxView(
                entity: ChatInboxEntity()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ChatInboxViewDemo()
    }
}
#endif
