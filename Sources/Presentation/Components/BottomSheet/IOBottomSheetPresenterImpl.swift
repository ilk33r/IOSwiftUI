//
//  IOBottomSheetPresenterImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import SwiftUI
import UIKit
import IOSwiftUIInfrastructure

final public class IOBottomSheetPresenterImpl: IOBottomSheetPresenter {
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates

    private var bottomSheetWindow: IOPresenterWindow?
    private var contentView: (any IOBottomSheetContentView)?

    // MARK: - New Instance

    public init() {
    }

    // MARK: - Presentation Methods

    public func show<Content: IOBottomSheetContentView>(_ handler: Handler<Content>) {
        if self.bottomSheetWindow != nil {
            return
        }
        
        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.bottomSheetWindow = IOPresenterWindow(frame: UIScreen.main.bounds)
        self.bottomSheetWindow?.windowLevel = .alert
        self.bottomSheetWindow?.backgroundColor = .clear
        
        let contentView = handler()
        let contentVC = UIHostingController(rootView: contentView)
        contentVC.modalPresentationStyle = .overFullScreen
        contentVC.modalTransitionStyle = .crossDissolve
        contentVC.view.backgroundColor = .clear
        
        self.bottomSheetWindow?.rootViewController = contentVC
        self.bottomSheetWindow?.windowScene = connectedScene
        self.bottomSheetWindow?.makeKeyAndVisible()
        
        contentView.data.presenter = self
        self.contentView = contentView
    }

    public func dismiss() {
        let animationDuration = self.contentView?.animationDuration ?? 0
        self.thread.runOnMainThread(afterMilliSecond: Int(animationDuration * 1000)) { [weak self] in
            let bottomSheetVC = self?.bottomSheetWindow?.rootViewController
            bottomSheetVC?.dismiss(animated: true, completion: nil)

            self?.contentView = nil
            self?.bottomSheetWindow?.resignKey()
            self?.bottomSheetWindow = nil
        }
    }
}
