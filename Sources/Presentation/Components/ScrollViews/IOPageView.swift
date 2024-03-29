//
//  IOPageView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import SwiftUI

public struct IOPageView<Content: View>: UIViewControllerRepresentable {
    
    // MARK: - Defs
    
    final public class Coordinator: NSObject {
        
        weak var viewController: IOPageViewController?

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
    @Binding private var currentPageListener: Int
    @Binding private var rootViewWidth: CGFloat
    @State private var currentPage = 0
    
    private var content: () -> Content

    // MARK: - Controller Representable
    
    public init(
        initialPage: Int,
        currentPage: Binding<Int>,
        rootViewWidth: Binding<CGFloat> = Binding.constant(0),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.initialPage = initialPage
        self._currentPageListener = currentPage
        self._rootViewWidth = rootViewWidth
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOPageViewController {
        let hostingController = IOSwiftUIViewController<AnyView>(rootView: viewForContent())
        let vc = IOPageViewController(
            initialPage: self.initialPage,
            hostingController: hostingController
        )
        context.coordinator.viewController = vc
        
        vc.setHandler { page in
            self.currentPageListener = page
        }
        
        return vc
    }

    public func updateUIViewController(_ viewController: IOPageViewController, context: Context) {
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
            .onChange(of: initialPage) { newValue in
                currentPage = newValue
            }
        
        return AnyView(view)
    }
}
