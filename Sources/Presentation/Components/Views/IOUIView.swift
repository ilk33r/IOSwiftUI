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
    private var lifecycleHandler: IOUIViewController<Content>.LifecycleHandler

    // MARK: - Controller Representable
    
    public init(
        lifecycleHandler: @escaping IOUIViewController<Content>.LifecycleHandler,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.lifecycleHandler = lifecycleHandler
        self.content = content
    }
    
    public func makeUIViewController(context: Context) -> IOUIViewController<Content> {
        let hostingController = IOSwiftUIViewController(rootView: content())
        let vc = IOUIViewController(
            hostingController: hostingController,
            handler: lifecycleHandler
        )
        return vc
    }
    
    public func updateUIViewController(_ viewController: IOUIViewController<Content>, context: Context) {
        viewController.hostingController.rootView = content()
    }
}
