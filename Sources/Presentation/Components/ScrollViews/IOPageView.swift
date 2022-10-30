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
            self.viewController?.setPage(page)
        }
    }

    // MARK: - Privates
    
    @Binding private var page: Int
    @State private var currentPage = 0
    
    private var content: () -> Content

    // MARK: - Controller Representable
    
    public init(
        page: Binding<Int>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._page = page
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOPageViewController {
        let vc = IOPageViewController()
        vc.hostingController.rootView = viewForContent()
        context.coordinator.viewController = vc
        return vc
    }

    public func updateUIViewController(_ viewController: IOPageViewController, context: Context) {
        context.coordinator.setPage(page)
        viewController.hostingController.rootView = viewForContent()
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    // MARK: - Helper Methods
    
    private func viewForContent() -> AnyView {
        let view = content()
            .onChange(of: page) { newValue in
                currentPage = newValue
            }
        
        return AnyView(view)
    }
}
