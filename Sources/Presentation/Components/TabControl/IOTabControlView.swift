//
//  IOTabControlView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import SwiftUI
import IOSwiftUIInfrastructure

public struct IOTabControlView<Content: View>: UIViewControllerRepresentable {
    
    // MARK: - Defs
    
    final public class Coordinator: NSObject {
        
        weak var viewController: IOTabControlViewController?

        override init() {
            super.init()
        }

        func setPage(_ page: Int) {
            viewController?.setPage(page)
        }
    }

    // MARK: - Privates
    
    private let tabControlHeight: CGFloat
    private let tabTitles: [String]
    
    @Binding private var page: Int
    @State private var currentPage = 0
    
    private var content: () -> Content

    // MARK: - Controller Representable
    
    public init(
        page: Binding<Int>,
        tabControlHeight: CGFloat,
        tabTitles: [String],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.tabControlHeight = tabControlHeight
        self.tabTitles = tabTitles
        self._page = page
        self.content = content
    }
    
    public init(
        page: Binding<Int>,
        tabControlHeight: CGFloat,
        tabTitles: [IOLocalizationType],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.tabControlHeight = tabControlHeight
        self.tabTitles = tabTitles.map({ $0.localized })
        self._page = page
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOTabControlViewController {
        let vc = IOTabControlViewController(
            tabControlHeight: self.tabControlHeight,
            tabTitles: self.tabTitles
        )
        vc.hostingController.rootView = viewForContent()
        context.coordinator.viewController = vc
        return vc
    }

    public func updateUIViewController(_ viewController: IOTabControlViewController, context: Context) {
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
