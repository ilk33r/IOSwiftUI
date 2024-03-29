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
        
        public init(clipsToBounds: Bool) {
            self.clipsToBounds = clipsToBounds
        }
    }
    
    final public class Coordinator: NSObject {
        
        weak var viewController: IOSnapScrollViewController<AnyView>?

        override init() {
            super.init()
        }

        func setPage(_ page: Int) {
            viewController?.setPage(page)
        }
        
        func updateWidth(_ width: CGFloat) {
            if width > 0 {
                viewController?.updateWidth(width)
            }
        }
    }

    // MARK: - Privates
    
    private let initialPage: Int
    private let configuration: Configuration
    private let content: () -> Content
    
    @Binding private var currentPage: Int
    @Binding private var itemWidth: CGFloat
    @Binding private var rootViewWidth: CGFloat

    // MARK: - Controller Representable
    
    public init(
        itemWidth: Binding<CGFloat>,
        initialPage: Int,
        rootViewWidth: Binding<CGFloat>,
        currentPage: Binding<Int> = Binding.constant(0),
        configuration: Configuration = .default,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.initialPage = initialPage
        self.configuration = configuration
        self.content = content
        self._itemWidth = itemWidth
        self._rootViewWidth = rootViewWidth
        self._currentPage = currentPage
    }

    public func makeUIViewController(context: Context) -> IOSnapScrollViewController<AnyView> {
        let vc = IOSnapScrollViewController<AnyView>(
            itemWidth: itemWidth,
            initialPage: initialPage,
            clipsToBounds: configuration.clipsToBounds
        )
        vc.setupHostingController(hostingController: IOSwiftUIViewController<AnyView>(rootView: viewForContent()))
        context.coordinator.viewController = vc
        
        vc.setPageChangeHandler { page in
            if currentPage != page {
                currentPage = page
            }
        }
        
        return vc
    }

    public func updateUIViewController(_ viewController: IOSnapScrollViewController<AnyView>, context: Context) {
        context.coordinator.setPage(currentPage)
        viewController.hostingController.rootView = viewForContent()
        
        context.coordinator.updateWidth(rootViewWidth)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // MARK: - Helper Methods
    
    private func viewForContent() -> AnyView {
        let view = content()
            .onChange(of: currentPage) { newValue in
                currentPage = newValue
            }
        
        return AnyView(view)
    }
}
