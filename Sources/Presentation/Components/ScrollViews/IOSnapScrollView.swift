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
    
    public struct Configuration {
        
        public let clipsToBounds: Bool
        
        public static var `default`: Self {
            Self(clipsToBounds: true)
        }
    }
    
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
    
    private var configuration: Configuration
    private var content: () -> Content

    // MARK: - Controller Representable
    
    public init(
        itemWidth: Binding<CGFloat>,
        rootViewWidth: Binding<CGFloat>,
        configuration: Configuration = .default,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._itemWidth = itemWidth
        self._rootViewWidth = rootViewWidth
        self.configuration = configuration
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOSnapScrollViewController<Content> {
        let vc = IOSnapScrollViewController<Content>(
            itemWidth: itemWidth,
            clipsToBounds: configuration.clipsToBounds
        )
        vc.setupHostingController(hostingController: IOSwiftUIViewController<Content>(rootView: self.content()))
        context.coordinator.viewController = vc
        
        return vc
    }

    public func updateUIViewController(_ viewController: IOSnapScrollViewController<Content>, context: Context) {
        viewController.hostingController.rootView = self.content()
        
        context.coordinator.updateWidth(rootViewWidth)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}
