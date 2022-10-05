// 
//  DiscoverView.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

struct DiscoverView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = DiscoverPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: DiscoverPresenter
    @StateObject public var navigationState = DiscoverNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    private let items = [
        DiscoverUIModel(
            image: Image("pwGallery0"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery1"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery2"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery3"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery4"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery5"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery0"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery1"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery2"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery3"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery0"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery4"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery5"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery0"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery1"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        ),
        DiscoverUIModel(
            image: Image("pwGallery3"),
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatar: Image("pwChatAvatar"),
            messageTime: "16 min ago"
        )
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(items) { item in
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
            if !self.isPreviewMode {
                self.presenter.environment = _appEnvironment
                self.presenter.loadValues(start: 0)
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
