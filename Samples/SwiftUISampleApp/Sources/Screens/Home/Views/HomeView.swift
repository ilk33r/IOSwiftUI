// 
//  HomeView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct HomeView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = HomePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: HomePresenter
    @StateObject public var navigationState = HomeNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var selectedIndex: Int = 0
    
    public var body: some View {
        EmptyView()
        /*
        IOTabBarView(
            controllerType: TabBarController.self,
            tabBarType: UITabBar.self,
            selection: $selectedIndex
        ) {
            return [
                IOIdentifiableView(
                    anyView: IORouterUtilities.route(
                        HomeRouters.self,
                        .discover(entity: nil)
                    ).setEnvironment(appEnvironment).contentView
                ),
                IOIdentifiableView(
                    anyView: IORouterUtilities.route(
                        HomeRouters.self,
                        .search(entity: nil)
                    ).setEnvironment(appEnvironment).contentView
                ),
                IOIdentifiableView(view: HomeTabEmptyView()),
                IOIdentifiableView(
                    anyView: IORouterUtilities.route(
                        HomeRouters.self,
                        .chatInbox(entity: nil)
                    ).setEnvironment(appEnvironment).contentView
                ),
                IOIdentifiableView(
                    anyView: IORouterUtilities.route(
                        HomeRouters.self,
                        .profile(entity: ProfileEntity(userName: nil))
                    ).setEnvironment(appEnvironment).contentView
                )
            ]
        }
        .onChange(of: selectedIndex) { newValue in
            if newValue == 2 {
                presenter.showActionSheet()
            }
        }
        .controllerWireframe {
            HomeNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
        }
        .fullScreenCover(isPresented: $navigationState.navigateToCamera) {
            IOImagePickerView(
                sourceType: .camera,
                allowEditing: true
            ) { image in
                presenter.interactor.uploadImage(image: image)
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToPhotoLibrary) {
            IOImagePickerView(
                sourceType: .photoLibrary,
                allowEditing: true
            ) { image in
                presenter.interactor.uploadImage(image: image)
            }
        }
        .actionSheet(item: $presenter.actionSheetData) { _ in
            ActionSheet(
                title: Text(type: .homeCameraActionsTitle),
                buttons: [
                    .default(
                        Text(type: .homeCameraActionsTakePhoto),
                        action: {
                            navigationState.navigateToCamera = true
                        }
                    ),
                    .default(
                        Text(type: .homeCameraActionsChoosePhoto),
                        action: {
                            navigationState.navigateToPhotoLibrary = true
                        }
                    ),
                    .destructive(
                        Text(type: .commonCancel),
                        action: {
                        }
                    )
                ]
            )
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        return HomeView(entity: HomeEntity())
            .environmentObject(SampleAppEnvironment())
    }
}
#endif
