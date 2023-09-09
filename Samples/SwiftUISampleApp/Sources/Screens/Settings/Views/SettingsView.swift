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
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct SettingsView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SettingsPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SettingsPresenter
    @StateObject public var navigationState = SettingsNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var showUpdateProfilePictureSheet = false
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                ScrollView {
                    LazyVStack {
                        ForEach(presenter.menu) { item in
                            SettingMenuItemView(menuItem: item) {
                                Task {
                                    await presenter.navigate(menu: item)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .title,
                    iconName: "slider.horizontal.3",
                    hasBackButton: true
                )
            }
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .navigationWireframe(hasNavigationView: false) {
            SettingsNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                presenter.prepare()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            
            presenter.prepare()
        }
        .actionSheet(data: $presenter.actionSheetData)
        .onReceive(navigationState.$selectedImage) { output in
            if let output {
                Task {
                    await presenter.deleteAndUploadProfilePicture(image: output)
                }
            }
        }
        .onReceive(presenter.$navigateToBack) { output in
            if output {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    
    struct SettingsViewDemo: View {
        
        var body: some View {
            SettingsView(
                entity: SettingsEntity(
                    member: MemberModel()
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return SettingsViewDemo()
    }
}
#endif
