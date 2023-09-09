// 
//  HomeView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct HomeView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = HomePresenter
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: HomePresenter
    @StateObject public var navigationState = HomeNavigationState()
    
    @EnvironmentObject public var appEnvironment: SampleAppEnvironment
    
    @State private var selectedIndex = 0
    @State private var updateViews = false
    
    // MARK: - Body
    
    public var body: some View {
        IOTabBarView(
            controllerType: TabBarController.self,
            tabBarType: UITabBar.self,
            selection: $selectedIndex,
            updateViews: $updateViews
        ) {
            if let tabViews = tabViews() {
                return tabViews
            } else {
                return []
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            HomeNavigationWireframe(navigationState: navigationState)
        }
        .actionSheet(data: $presenter.actionSheetData)
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            updateViews = true
        }
        .onChange(of: selectedIndex) { newValue in
            if newValue == 2 {
                presenter.showActionSheet()
            }
        }
        .onReceive(navigationState.$selectedImage) { output in
            if let output {
                Task {
                    await presenter.uploadImage(image: output)
                }
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    // MARK: - Helper Methods
    
    private func tabViews() -> [IOIdentifiableView]? {
        [
            IOIdentifiableView(
                anyView: IORouterUtilities.route(
                    HomeRouters.self,
                    .discover(entity: nil)
                )
                .setEnvironment(appEnvironment).contentView
            ),
            IOIdentifiableView(
                anyView: IORouterUtilities.route(
                    HomeRouters.self,
                    .search(entity: nil)
                )
                .setEnvironment(appEnvironment).contentView
            ),
            IOIdentifiableView(view: HomeTabEmptyView()),
            IOIdentifiableView(
                anyView: IORouterUtilities.route(
                    HomeRouters.self,
                    .chatInbox(entity: nil)
                )
                .setEnvironment(appEnvironment).contentView
            ),
            IOIdentifiableView(
                anyView: IORouterUtilities.route(
                    HomeRouters.self,
                    .profile(
                        entity: ProfileEntity(
                            navigationBarHidden: false,
                            userName: nil,
                            fromDeepLink: false,
                            member: nil
                        )
                    )
                )
                .setEnvironment(appEnvironment).contentView
            )
        ]
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    
    struct HomeViewDemo: View {
        
        var body: some View {
            HomeView(
                entity: HomeEntity()
            )
            .environmentObject(SampleAppEnvironment())
        }
    }
    
    static var previews: some View {
        prepare()
        return HomeViewDemo()
    }
}
#endif
