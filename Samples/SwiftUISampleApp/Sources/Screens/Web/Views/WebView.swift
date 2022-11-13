// 
//  WebView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import WebKit
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

public struct WebView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = WebPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: WebPresenter
    @StateObject public var navigationState = WebNavigationState()
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOWebView { webView in
                    presenter.loadPage(webView: webView)
                }
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    presenter.interactor.entity.pageTitle,
                    iconName: presenter.interactor.entity.titleIcon,
                    width: 12
                )
            }
        }
        .controllerWireframe {
            WebNavigationWireframe(navigationState: navigationState)
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

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(
            entity: WebEntity(
                pageName: "PrivacyPolicy",
                pageTitle: .init(rawValue: "Privacy Policy"),
                titleIcon: "doc.text"
            )
        )
    }
}
