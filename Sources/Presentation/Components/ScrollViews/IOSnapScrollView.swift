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
        
        weak var viewController: IOSnapScrollViewController?

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
        rootViewWidth: Binding<CGFloat> = Binding.constant(0),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._itemWidth = itemWidth
        self._rootViewWidth = rootViewWidth
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOSnapScrollViewController {
        let vc = IOSnapScrollViewController(itemWidth: itemWidth)
        vc.hostingController.rootView = viewForContent()
        context.coordinator.viewController = vc
        
        return vc
    }

    public func updateUIViewController(_ viewController: IOSnapScrollViewController, context: Context) {
        viewController.hostingController.rootView = viewForContent()
        
        context.coordinator.updateWidth(rootViewWidth)
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    // MARK: - Helper Methods
    
    private func viewForContent() -> AnyView {
        let view = content()
        return AnyView(view)
    }
}
