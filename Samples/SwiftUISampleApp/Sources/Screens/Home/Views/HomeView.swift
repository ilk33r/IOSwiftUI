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
    
    @State private var selectedIndex: Int = 0
    
    public var body: some View {
        IOTabBarView(
            controllerType: TabBarController.self,
            tabBarType: UITabBar.self,
            selection: $selectedIndex
        ) {
            return [
//                IOIdentifiableView(view: DiscoverView(entity: DiscoverEntity())),
                IOIdentifiableView(view: HomeTabEmptyView())
//                IOIdentifiableView(view: ChatInboxView(entity: ChatInboxEntity())),
//                IOIdentifiableView(view: ProfileView(entity: ProfileEntity(userName: nil)))
            ]
        }
        .onChange(of: selectedIndex) { newValue in
            if newValue == 1 {
                presenter.showActionSheet()
            }
        }
        .controllerWireframe {
            HomeNavigationWireframe(navigationState: navigationState)
        }
        .fullScreenCover(isPresented: $navigationState.navigateToCamera) {
            IOImagePickerView(
                sourceType: .camera,
                allowEditing: true
            ) { _ in
                
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToPhotoLibrary) {
            IOImagePickerView(
                sourceType: .photoLibrary,
                allowEditing: true
            ) { _ in
                
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
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(entity: HomeEntity())
    }
}
