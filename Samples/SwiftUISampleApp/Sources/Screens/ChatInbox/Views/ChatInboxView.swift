// 
//  ChatInboxView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI

struct ChatInboxView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ChatInboxPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ChatInboxPresenter
    @StateObject public var navigationState = ChatInboxNavigationState()
    
    var body: some View {
        GeometryReader { proxy in
            List {
                Section {
                    ForEach(0..<100) { _ in
                        let itemView = ChatInboxItemView()
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
            .frame( maxWidth: .infinity)
            .listStyle(InsetListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Title").font(.headline)
                        Text("Subtitle").font(.subheadline)
                    }
                }
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .uiKit {
            UIKitView(type: UITableView.self) { view in
                view.separatorStyle = .none
                view.separatorColor = .clear
                view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        .navigationView(wireframeView: {
            ChatInboxNavigationWireframe(navigationState: navigationState)
        })
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ChatInboxView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInboxView(entity: ChatInboxEntity())
    }
}
