// 
//  WebPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import WebKit

final public class WebPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: WebInteractor!
    public var navigationState: StateObject<WebNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func loadPage(webView: WKWebView) {
        let resourcesBundle = Bundle.resources
        
        if let fileURL = resourcesBundle.url(forResource: self.interactor.entity.pageName, withExtension: "html") {
            webView.loadFileURL(fileURL, allowingReadAccessTo: resourcesBundle.bundleURL)
        }
    }
}
