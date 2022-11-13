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
import SwiftUISampleAppPresentation

public struct FriendsView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = FriendsPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: FriendsPresenter
    @StateObject public var navigationState = FriendsNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var tabControlPage = 0
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOTabControlView(
                    page: $tabControlPage,
                    tabControlHeight: 52,
                    tabTitles: [
                        .friendsTabFollowers,
                        .friendsTabFollowing
                    ]
                ) {
                    LazyHStack {
                        Text("Page 1")
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height - 52,
                                alignment: .top
                            )
                        
                        Text("Page 2")
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height - 52,
                                alignment: .top
                            )
                    }
                }
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .friendsTitle,
                    iconName: "person.3.fill",
                    width: 20,
                    height: 14
                )
            }
        }
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
