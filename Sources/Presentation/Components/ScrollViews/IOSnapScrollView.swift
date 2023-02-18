//
//  IOSnapScrollView.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.02.2023.
//

import Foundation
import SwiftUI

public struct IOSnapScrollView<Content: View>: UIViewControllerRepresentable {
    
    // MARK: - Defs
    
    final public class Coordinator: NSObject {
        
        weak var viewController: IOSnapScrollViewController<Content>?

        override init() {
            super.init()
        }

        func updateWidth(_ width: CGFloat) {
            if width > 0 {
                viewController?.updateWidth(width)
            }
        }
    }

    // MARK: - Privates
    
    @Binding private var itemWidth: CGFloat
    @Binding private var rootViewWidth: CGFloat
    
    private var content: () -> Content

    // MARK: - Controller Representable
    
    public init(
        itemWidth: Binding<CGFloat>,
        rootViewWidth: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._itemWidth = itemWidth
        self._rootViewWidth = rootViewWidth
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOSnapScrollViewController<Content> {
        let vc = IOSnapScrollViewController<Content>(itemWidth: itemWidth)
        vc.setupHostingController(hostingController: IOSwiftUIViewController<Content>(rootView: self.content()))
        context.coordinator.viewController = vc
        
        return vc
    }

    public func updateUIViewController(_ viewController: IOSnapScrollViewController<Content>, context: Context) {
        viewController.hostingController.rootView = self.content()
        
        context.coordinator.updateWidth(rootViewWidth)
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
