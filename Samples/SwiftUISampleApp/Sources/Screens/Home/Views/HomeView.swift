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

public struct HomeView: IONavigationController {
    
    // MARK: - Generics
    
    public typealias Presenter = HomePresenter
    public typealias Wireframe = HomeNavigationWireframe
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: HomePresenter
    @StateObject public var navigationState = HomeNavigationState()
    
    @State private var selectedIndex: Int = 0
    
    public var controllerBody: some View {
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
            
            SearchView()
                .tabItem {
                    TabBarItemView {
                        Image.icnTabBarCamera.renderingMode(.original)
                    }
                }
            
            LoginView(entity: LoginEntity())
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
    }
    
    public var wireframeView: HomeNavigationWireframe {
        HomeNavigationWireframe(navigationState: navigationState)
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
        
        let tabBarAppeareance = UITabBarAppearance()
        tabBarAppeareance.configureWithOpaqueBackground()
        tabBarAppeareance.shadowImage = UIImage()
        tabBarAppeareance.shadowColor = Color.colorPassthrought.convertUI()
        tabBarAppeareance.backgroundColor = .white
        
        UITabBar.appearance().standardAppearance = tabBarAppeareance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppeareance
        }
    }
}

struct SearchView: View {
    
    var body: some View {
        List {
            ForEach(0..<50) { _ in
                TabBarItemCenterViews()
            }
        }
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
