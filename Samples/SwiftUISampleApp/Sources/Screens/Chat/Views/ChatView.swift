// 
//  ChatView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppComponents

struct ChatView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ChatPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ChatPresenter
    @StateObject public var navigationState = ChatNavigationState()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                ScrollViewReader { proxy in
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBar {
            NavBarTitleView(.init(rawValue: "James"))
        }
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
