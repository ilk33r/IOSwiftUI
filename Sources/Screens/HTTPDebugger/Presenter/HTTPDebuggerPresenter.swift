//
//  HTTPDebuggerPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

#if DEBUG
import Foundation
import UIKit
import SwiftUI

final public class HTTPDebuggerPresenter {
    
    // MARK: - Privates

    private var presenterWindow: UIWindow?

    // MARK: - New Instance

    public init() {
    }

    // MARK: - Presentation Methods

    public func show() {
        if self.presenterWindow != nil {
            return
        }

        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.presenterWindow = UIWindow(frame: UIScreen.main.bounds)
        self.presenterWindow?.windowLevel = .alert
        self.presenterWindow?.backgroundColor = .lightGray
        
        let contentView = HTTPDebuggerView()
        
        let contentVC = UIHostingController(rootView: contentView)
        contentVC.modalPresentationStyle = .overFullScreen
        contentVC.modalTransitionStyle = .crossDissolve
        contentVC.view.backgroundColor = .clear
        
        self.presenterWindow?.rootViewController = contentVC
        self.presenterWindow?.windowScene = connectedScene
        self.presenterWindow?.makeKeyAndVisible()
    }
    
    public func dismiss() {
        self.presenterWindow?.resignKey()
        self.presenterWindow = nil
    }
}
#endif
