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
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared
import WebKit

public struct WebView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = WebPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: WebPresenter
    @StateObject public var navigationState = WebNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
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
        .navigationWireframe(hasNavigationView: false) {
            WebNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct WebView_Previews: PreviewProvider {
    
    struct WebViewDemo: View {
        
        var body: some View {
            WebView(
                entity: WebPreviewData.previewData
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return WebViewDemo()
    }
}
#endif
