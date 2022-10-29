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
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    public var body: some View {
        GeometryReader { proxy in
            List {
                Section {
                    ForEach(presenter.inboxes) { inbox in
                        let itemView = ChatInboxItemView(
                            uiModel: inbox,
                            clickHandler: { index in
                                IOLogger.verbose("Chat item tapped \(index)")
                            }
                        )
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        if #available(iOS 15.0, *) {
                            itemView
                                .listRowSeparator(.hidden)
                        } else {
                            itemView
                        }
                    }
                } header: {
                    EmptyView()
                        .frame(height: 0)
                } footer: {
                    EmptyView()
                        .frame(height: proxy.safeAreaInsets.bottom + proxy.safeAreaInsets.top)
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(InsetListStyle())
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
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.interactor.getInboxes()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ChatInboxView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInboxView(entity: ChatInboxEntity())
    }
}
