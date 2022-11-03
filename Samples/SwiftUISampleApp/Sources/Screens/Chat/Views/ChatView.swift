// 
//  ChatView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

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
    
    @State private var isKoyboardVisible = false
    @State private var messageText: String = ""
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @IOInstance private var thread: IOThreadImpl
    
    public var body: some View {
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
                        ScrollView {
                            ScrollViewReader { _ in
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
                    .padding(.bottom, isKoyboardVisible ? 0 : -proxy.safeAreaInsets.bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(.init(rawValue: presenter.userNameSurname), iconName: "ellipsis.message")
            }
        }
        .onReceive(presenter.keyboardPublisher, perform: { value in
            isKoyboardVisible = value
        })
        .controllerWireframe {
            ChatNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.loadInitialMessages()
            }
        }
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
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(
            entity: ChatEntity(
                toMemberId: 0,
                inbox: nil,
                messages: [],
                pagination: PaginationModel(start: 0, count: 10, total: nil)
            )
        )
    }
}
