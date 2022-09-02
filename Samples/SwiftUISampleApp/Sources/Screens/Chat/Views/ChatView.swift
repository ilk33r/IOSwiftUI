// 
//  ChatView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import IOSwiftUIPresentation
import IOSwiftUIComponents
import SwiftUI
import SwiftUISampleAppComponents

struct ChatView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ChatPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ChatPresenter
    @StateObject public var navigationState = ChatNavigationState()
    
    @State private var isKoyboardVisible: Bool = false
    @State private var messageText: String = ""
    
    private let items = [
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Hello!",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Hi!",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "A fast 50mm like f1.8 would help with the bokeh. I’ve been using primes as they tend to get a bit sharper images.",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Vestibulum at nisl sit amet turpis lobortis lobortis.",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Nunc ut libero ac massa egestas viverra ut eu velit.",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Donec in augue eget justo rhoncus maximus.",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Vestibulum id elit congue neque venenatis molestie tincidunt at lorem.",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Aliquam ut sem sed felis lacinia bibendum.",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Nullam suscipit ante at ante cursus, congue placerat massa mattis.",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        ),
        ChatItemUIModel(
            image: Image("pwProfilePicture"),
            chatMessage: "Thank you! That was very helpful!",
            isLastMessage: true,
            isSend: false,
            messageTime: "16 min ago"
        )
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    ScrollView {
                        ScrollViewReader { scrollProxy in
                            LazyVStack {
                                ForEach(items) { item in
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
                    ChatTextEditorView(.chatInputPlaceholder, text: $messageText)
                        .padding(.bottom, isKoyboardVisible ? 0 : -proxy.safeAreaInsets.bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(.init(rawValue: "James"))
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .onAppear {
            presenter.hideTabBar()
        }
        .onReceive(presenter.keyboardPublisher, perform: { value in
            isKoyboardVisible = value
        })
        .controllerWireframe {
            ChatNavigationWireframe(navigationState: navigationState)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(entity: ChatEntity())
    }
}
