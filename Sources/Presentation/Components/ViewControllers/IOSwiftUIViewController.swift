//
//  IOSwiftUIViewController.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.02.2023.
//

import Foundation
import IOSwiftUICommon
import SwiftUI

final public class IOSwiftUIViewController<Content: View>: UIHostingController<Content> {
    
    public override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        // Adjust only when top safeAreaInset is not equal to bottom
        guard self.view.safeAreaInsets.top != self.view.safeAreaInsets.bottom else {
            return
        }

        // Set additionalSafeAreaInsets to .zero before adjust to prevent accumulation
        guard additionalSafeAreaInsets == .zero else {
            self.additionalSafeAreaInsets = .zero
            return
        }

        // Use gap between top and bottom safeAreaInset to adjust top inset
        self.additionalSafeAreaInsets.top = self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top
    }
    
    // MARK: - Helper Methods
    
    public func add(
        parent: UIViewController,
        toView: UIView,
        constraints: [IOConstraints]
    ) {
        self.willMove(toParent: parent)
        toView.addSubview(
            view: self.view,
            constraints: constraints
        )
        self.view.backgroundColor = .clear
        self.didMove(toParent: parent)
    }
}
