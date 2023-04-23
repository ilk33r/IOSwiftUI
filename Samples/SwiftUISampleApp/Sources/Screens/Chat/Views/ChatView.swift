// 
//  ChatView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct ChatView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = ChatPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ChatPresenter
    @StateObject public var navigationState = ChatNavigationState()
    
    @State private var isKeyboardVisible = false
    @State private var messageText: String = ""
    @State private var previousMessageThreadCancellable: IOCancellable?
    @State private var scrollViewContentSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = 0
    @State private var scrollViewProxy: ScrollViewProxy?
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @IOInject private var thread: IOThread
    
    // MARK: - Body
    
    public var body: some View {
        EmptyView()
        /*
        GeometryReader { proxy in
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
            ZStack(alignment: .top) {
                VStack {
                    IOUIView { lifecycle in
                        if lifecycle == .willAppear {
                            presenter.hideTabBar()
                        } else if lifecycle == .willDisappear {
                            presenter.showTabBar()
                        }
                    } content: {
                        IOObservableScrollView(
                            contentSize: $scrollViewContentSize,
                            scrollOffset: $scrollViewOffset
                        ) { scrollViewProxy in
                            LazyVStack {
                                ForEach(presenter.chatMessages) { item in
                                    if item.isSend {
                                        ChatSendCellView(uiModel: item)
                                    } else {
                                        ChatReceivedCellView(uiModel: item)
                                    }
                                }
                            }
                            .padding(.top, 8)
                            .onAppear {
                                self.scrollViewProxy = scrollViewProxy
                            }
                        }
                        .hideKeyboardOnTap()
                    }
                    ChatTextEditorView(
                        .chatInputPlaceholder,
                        text: $messageText,
                        handler: {
                            sendMessage()
                        }
                    )
                    .padding(.bottom, isKeyboardVisible ? 0 : -proxy.safeAreaInsets.bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .init(rawValue: presenter.userNameSurname),
                    iconName: "keyboard",
                    height: 12
                )
            }
        }
        .onReceive(presenter.keyboardPublisher, perform: { value in
            isKeyboardVisible = value
            
            if value, let lastMessageID = presenter.chatMessages.last?.id {
                thread.runOnMainThread(afterMilliSecond: 250) {
                    withAnimation {
                        scrollViewProxy?.scrollTo(lastMessageID)
                    }
                }
            }
        })
        .controllerWireframe {
            ChatNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.loadInitialMessages()
        }
        .onReceive(presenter.$chatMessages) { chatMessages in
            if chatMessages.last != nil && presenter.scrollToLastMessage {
                presenter.scrollToLastMessage = false
                
                guard let lastMessageID = chatMessages.last?.id else { return }
                thread.runOnMainThread {
                    withAnimation {
                        scrollViewProxy?.scrollTo(lastMessageID, anchor: .bottom)
                    }
                }
            } else if
                let messageCount = presenter.messageCount,
                messageCount > 1,
                chatMessages.count > messageCount {
                let scrollToMessageID = chatMessages[messageCount - 1].id
                
                thread.runOnMainThread(afterMilliSecond: 25) {
                    withAnimation {
                        scrollViewProxy?.scrollTo(scrollToMessageID, anchor: .top)
                    }
                }
            }
        }
        .onChange(of: scrollViewOffset) { newValue in
            IOLogger.debug("scrollViewOffset \(newValue)")
            if previousMessageThreadCancellable != nil {
                previousMessageThreadCancellable?.cancel()
            }
            
            if newValue <= 0 {
                loadPreviousMessages()
            }
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    // MARK: - Helper Methods
    
    private func sendMessage() {
        if messageText.isEmpty {
            return
        }
        
        presenter.interactor.sendMessage(message: messageText)
        thread.runOnMainThread {
            messageText = ""
        }
    }
    
    private func loadPreviousMessages() {
        previousMessageThreadCancellable = thread.runOnMainThread(afterMilliSecond: 150) {
            presenter.loadPreviousMessages()
        }
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return ChatView(
            entity: ChatEntity(
                toMemberId: 0,
                inbox: nil,
                messages: [],
                pagination: PaginationModel(start: 0, count: 10, total: nil)
            )
        )
    }
}
#endif
