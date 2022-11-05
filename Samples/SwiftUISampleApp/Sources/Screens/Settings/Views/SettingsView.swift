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
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                ScrollView {
                    LazyVStack {
                        ForEach(presenter.menu) { item in
                            SettingMenuItemView(menuItem: item) {
                                
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
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.interactor.loadMenu()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            entity: SettingsEntity(
                member: MemberModel()
            )
        )
    }
}
