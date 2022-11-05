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

public struct SettingsView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SettingsPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SettingsPresenter
    @StateObject public var navigationState = SettingsNavigationState()
    
//    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        Text("Settings")
            .controllerWireframe {
                SettingsNavigationWireframe(navigationState: navigationState)
            }
            .onAppear {
//              if !isPreviewMode {
//                  presenter.environment = _appEnvironment
//              }
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
