// 
//  HomeView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import IOSwiftUIComponents
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppComponents

public struct HomeView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = HomePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: HomePresenter
    @StateObject public var navigationState = HomeNavigationState()
    
    @State private var selectedIndex: Int = 0
    
    public var body: some View {
        TabView(selection: $selectedIndex) {
            RegisterView()
                .tabItem {
                    TabBarItemView {
                        Image.icnTabBarHome.renderingMode(.template)
                    }
                }
            
            LoginView(entity: LoginEntity())
                .tabItem {
                    TabBarItemView {
                        Image.icnTabBarSearch.renderingMode(.template)
                    }
                }
            
            RegisterView()
                .tabItem {
                    TabBarItemView {
                        Image.icnTabBarCamera.renderingMode(.original)
                    }
                }
            
            ChatInboxView(entity: ChatInboxEntity())
                .tabItem {
                    TabBarItemView {
                        Image.icnTabBarChat.renderingMode(.template)
                    }
                }
            
            RegisterView()
                .tabItem {
                    TabBarItemView {
                        Image.icnTabBarProfile.renderingMode(.template)
                    }
                }
        }
        .accentColor(.colorTabEnd)
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .navigationView {
            HomeNavigationWireframe(navigationState: navigationState)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

extension UITabBarController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(entity: HomeEntity())
    }
}
