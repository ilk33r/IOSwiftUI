//
//  IOIndicatorPresenterImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation
import SwiftUI
import UIKit

final public class IOIndicatorPresenterImpl<Content: View>: IOIndicatorPresenter {
    
    // MARK: - Privates

    private var contentView: () -> Content
    private var indicatorWindow: IOPresenterWindow?

    // MARK: - New Instance

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.contentView = content
    }

    // MARK: - Presentation Methods

    public func show() {
        if self.indicatorWindow != nil {
            return
        }

        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.indicatorWindow = IOPresenterWindow(frame: UIScreen.main.bounds)
        self.indicatorWindow?.windowLevel = .normal
        self.indicatorWindow?.backgroundColor = .clear

        let indicatorVC = UIHostingController(rootView: self.contentView())
        indicatorVC.modalPresentationStyle = .overFullScreen
        indicatorVC.modalTransitionStyle = .crossDissolve
        indicatorVC.view.backgroundColor = .clear
        
        self.indicatorWindow?.rootViewController = indicatorVC
        self.indicatorWindow?.windowScene = connectedScene
        self.indicatorWindow?.makeKeyAndVisible()
    }

    public func dismiss() {
        let indicatorVC = self.indicatorWindow?.rootViewController as? UIHostingController<Content>
        indicatorVC?.dismiss(animated: true, completion: nil)

        self.indicatorWindow?.resignKey()
        self.indicatorWindow = nil
    }
}
