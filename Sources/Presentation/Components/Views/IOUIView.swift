//
//  IOUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import SwiftUI

public struct IOUIView<Content: View>: UIViewControllerRepresentable {
    
    // MARK: - Privates
    
    private var content: () -> Content
    private var lifecycleHandler: IOUIViewController.LifecycleHandler

    // MARK: - Controller Representable
    
    public init(
        lifecycleHandler: @escaping IOUIViewController.LifecycleHandler,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.lifecycleHandler = lifecycleHandler
        self.content = content
    }
    
    public func makeUIViewController(context: Context) -> IOUIViewController {
        let vc = IOUIViewController(handler: self.lifecycleHandler)
        vc.hostingController.rootView = AnyView(self.content())
        return vc
    }
    
    public func updateUIViewController(_ viewController: IOUIViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())
    }
}
