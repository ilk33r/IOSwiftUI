//
//  IOWebView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import SwiftUI
import WebKit

public struct IOWebView: UIViewRepresentable {
    
    // MARK: - Defs
    
    public typealias Configuration = (_ webView: WKWebView) -> Void
    public typealias UIViewType = WKWebView
    
    // MARK: - Privates
    
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(
        configuration: Configuration? = nil
    ) {
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webViewConfiguration = WKWebViewConfiguration()
        
        if #available(iOS 14.0, *) {
            webViewConfiguration.defaultWebpagePreferences.allowsContentJavaScript = true
        } else {
            webViewConfiguration.preferences.javaScriptEnabled = true
        }
        
        if #available(iOS 13.0, *) {
            webViewConfiguration.defaultWebpagePreferences.preferredContentMode = .mobile
        }
        
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        configuration?(uiView)
    }
}
