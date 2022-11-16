//
//  HTTPDebuggerPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation
import UIKit
import SwiftUI

final public class HTTPDebuggerPresenter {
    
    // MARK: - Privates

    private var presenterWindow: UIWindow?
    private weak var hostingController: UIHostingController<HTTPDebuggerView>?

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
        
        self.hostingController = contentVC
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(HTTPDebuggerPresenter.handleShareNotification(_:)),
            name: .httpDebuggerShareLog,
            object: nil
        )
    }
    
    public func dismiss() {
        NotificationCenter.default.removeObserver(self)
        self.presenterWindow?.resignKey()
        self.presenterWindow = nil
    }
    
    // MARK: - Actions
    
    @objc dynamic private func handleShareNotification(_ sender: Notification!) {
        guard let httpHistory = sender.userInfo?["httpHistory"] as? String else { return }
        
        // Create activity view controller
        let activityViewController = UIActivityViewController(
            activityItems: [httpHistory],
            applicationActivities: nil
        )

        self.hostingController?.present(activityViewController, animated: true)
    }
}
