// 
//  SettingsView.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

public struct SettingsView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SettingsPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SettingsPresenter
    @StateObject public var navigationState = SettingsNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var showUpdateProfilePictureSheet = false
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                ScrollView {
                    LazyVStack {
                        ForEach(presenter.menu) { item in
                            SettingMenuItemView(menuItem: item) {
                                presenter.navigate(menu: item)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .settingsTitle,
                    iconName: "slider.horizontal.3"
                )
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .controllerWireframe {
            SettingsNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                presenter.interactor.loadMenu()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            presenter.interactor.loadMenu()
        }
        .fullScreenCover(isPresented: $navigationState.navigateToCamera) {
            IOImagePickerView(
                sourceType: .camera,
                allowEditing: true
            ) { image in
                presenter.interactor.deleteAndUploadProfilePicture(image: image)
            }
        }
        .fullScreenCover(isPresented: $navigationState.navigateToPhotoLibrary) {
            IOImagePickerView(
                sourceType: .photoLibrary,
                allowEditing: true
            ) { image in
                presenter.interactor.deleteAndUploadProfilePicture(image: image)
            }
        }
        .actionSheet(item: $presenter.actionSheetData) { _ in
            ActionSheet(
                title: Text(type: .settingsCameraActionsTitle),
                buttons: [
                    .default(
                        Text(type: .settingsCameraActionsTakePhoto),
                        action: {
                            navigationState.navigateToCamera = true
                        }
                    ),
                    .default(
                        Text(type: .settingsCameraActionsChoosePhoto),
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

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        return SettingsView(
            entity: SettingsEntity(
                member: MemberModel()
            )
        )
    }
}
#endif
