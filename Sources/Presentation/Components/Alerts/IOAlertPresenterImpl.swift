//
//  IOAlertPresenterImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.11.2022.
//

import Foundation
import SwiftUI
import UIKit

final public class IOAlertPresenterImpl: IOAlertPresenter {
    
    // MARK: - Privates

    private var alertWindow: IOPresenterWindow?

    // MARK: - New Instance

    public init() {
    }

    // MARK: - Presentation Methods

    public func show(handler: @escaping IOAlertHandler) {
        if self.alertWindow != nil {
            return
        }

        let connectedScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        self.alertWindow = IOPresenterWindow(frame: UIScreen.main.bounds)
        self.alertWindow?.windowLevel = .alert
        self.alertWindow?.backgroundColor = .clear
        
        let contentVC = UIViewController()
        contentVC.modalPresentationStyle = .overFullScreen
        contentVC.modalTransitionStyle = .crossDissolve
        contentVC.view.backgroundColor = .clear
        
        self.alertWindow?.rootViewController = contentVC
        self.alertWindow?.windowScene = connectedScene
        self.alertWindow?.makeKeyAndVisible()
        
        let alertVC = self.generateAlert(data: handler())
        contentVC.present(alertVC, animated: true)
    }

    public func dismiss() {
        let alertVC = self.alertWindow?.rootViewController as? UIAlertController
        alertVC?.dismiss(animated: true, completion: nil)

        self.alertWindow?.resignKey()
        self.alertWindow = nil
    }
    
    // MARK: - Helper Methods
    
    private func generateAlert(data: IOAlertData) -> UIAlertController {
        let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
        
        data.buttons.enumerated().forEach { [weak self] item in
            let style: UIAlertAction.Style
            
            if item.offset == data.buttons.count - 1 {
                style = .destructive
            } else {
                style = .default
            }
            
            let alertAction = UIAlertAction(title: item.element, style: style) { [weak self] _ in
                data.handler?(item.offset)
                self?.dismiss()
            }
            
            alertController.addAction(alertAction)
        }
        
        return alertController
    }
}
