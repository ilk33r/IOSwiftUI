//
//  IOToastPresenterImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.01.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

final public class IOToastPresenterImpl<Content: View>: IOToastPresenter {
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates

    private var contentView: (_ data: IOToastData) -> Content
    private var toastWindow: IOPresenterWindow?

    // MARK: - New Instance

    public init(@ViewBuilder content: @escaping (_ data: IOToastData) -> Content) {
        self.contentView = content
    }

    // MARK: - Presentation Methods

    public func show(handler: @escaping IOToastData.DataHandler) {
        if self.toastWindow != nil {
            return
        }

        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.toastWindow = IOPresenterWindow(frame: UIScreen.main.bounds)
        self.toastWindow?.windowLevel = .normal
        self.toastWindow?.backgroundColor = .clear

        let toastData = handler()
        let toastVC = UIHostingController(rootView: self.contentView(toastData))
        toastVC.modalPresentationStyle = .overFullScreen
        toastVC.modalTransitionStyle = .crossDissolve
        toastVC.view.backgroundColor = .clear
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Self.handleBackgroundTapped(_:)))
        toastVC.view.addGestureRecognizer(tapGestureRecognizer)
        
        self.toastWindow?.rootViewController = toastVC
        self.toastWindow?.windowScene = connectedScene
        self.toastWindow?.makeKeyAndVisible()
        
        self.thread.runOnMainThread(afterMilliSecond: toastData.duration + 500) { [weak self] in
            self?.dismiss()
        }
    }

    public func dismiss() {
        let toastVC = self.toastWindow?.rootViewController as? UIHostingController<Content>
        toastVC?.dismiss(animated: true, completion: nil)

        self.toastWindow?.resignKey()
        self.toastWindow = nil
    }
    
    // MARK: - Helper Methods
    
    @objc dynamic private func handleBackgroundTapped(_ sender: UITapGestureRecognizer!) {
        self.dismiss()
    }
}
