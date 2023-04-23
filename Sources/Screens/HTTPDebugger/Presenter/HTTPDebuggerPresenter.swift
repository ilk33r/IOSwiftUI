//
//  HTTPDebuggerPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Combine
import Foundation
import IOSwiftUIInfrastructure
import SwiftUI
import UIKit

final public class HTTPDebuggerPresenter {
    
    // MARK: - DI
    
    @IOInject private var eventProcess: IOEventProcess
    
    // MARK: - Privates

    private var httpDebuggerShareLogCancel: AnyCancellable?
    private var presenterWindow: UIWindow?
    private weak var hostingController: UIHostingController<HTTPDebuggerView>?

    private var httpDebuggerShareLog: AnyPublisher<String?, Never> {
        self.eventProcess.string(forType: .httpDebuggerShareLog)
    }
    
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
        
        self.httpDebuggerShareLogCancel = self.httpDebuggerShareLog
            .sink { _ in
                IOLogger.debug("httpDebuggerShareLog completed")
            } receiveValue: { [weak self] newValue in
                if let httpHistory = newValue {
                    self?.handleShareNotification(httpHistory: httpHistory)
                }
            }
    }
    
    public func dismiss() {
        self.httpDebuggerShareLogCancel?.cancel()
        self.httpDebuggerShareLogCancel = nil
        self.presenterWindow?.resignKey()
        self.presenterWindow = nil
    }
    
    // MARK: - Actions
    
    private func handleShareNotification(httpHistory: String) {
        // Create activity view controller
        let activityViewController = UIActivityViewController(
            activityItems: [httpHistory],
            applicationActivities: nil
        )

        self.hostingController?.present(activityViewController, animated: true)
    }
}
