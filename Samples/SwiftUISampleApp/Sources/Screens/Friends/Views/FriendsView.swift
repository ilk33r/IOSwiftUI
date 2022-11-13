// 
//  FriendsView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

public struct FriendsView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = FriendsPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: FriendsPresenter
    @StateObject public var navigationState = FriendsNavigationState()
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        Text("Friends")
//            .navigationWireframe {
//                FriendsNavigationWireframe(navigationState: navigationState)
//            }
            .controllerWireframe {
                FriendsNavigationWireframe(navigationState: navigationState)
            }
            .onAppear {
                if !isPreviewMode {
                    presenter.environment = _appEnvironment
                    presenter.navigationState = _navigationState
                }
            }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(entity: FriendsEntity())
    }
}
