//
//  IOTabControlView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

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
        
        func update(tabTitles: [String]) {
            viewController?.update(tabTitles: tabTitles)
        }
    }

    // MARK: - Privates
    
    private let tabControlHeight: CGFloat
    private let tabTitles: [String]
    private let textColor: UIColor
    private let font: UIFont
    private let lineColor: UIColor
    private let lineHeight: CGFloat
    
    @Binding private var page: Int
    @State private var currentPage = 0
    
    private var content: () -> Content

    // MARK: - Controller Representable
    
    public init(
        page: Binding<Int>,
        tabControlHeight: CGFloat,
        tabTitles: [String],
        textColor: UIColor,
        font: UIFont,
        lineColor: UIColor,
        lineHeight: CGFloat,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.tabControlHeight = tabControlHeight
        self.tabTitles = tabTitles
        self._page = page
        self.content = content
        self.textColor = textColor
        self.font = font
        self.lineColor = lineColor
        self.lineHeight = lineHeight
    }
    
    public init(
        page: Binding<Int>,
        tabControlHeight: CGFloat,
        tabTitles: [IOLocalizationType],
        textColor: UIColor,
        font: UIFont,
        lineColor: UIColor,
        lineHeight: CGFloat,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.tabControlHeight = tabControlHeight
        self.tabTitles = tabTitles.map({ $0.localized })
        self._page = page
        self.content = content
        self.textColor = textColor
        self.font = font
        self.lineColor = lineColor
        self.lineHeight = lineHeight
    }

    public func makeUIViewController(context: Context) -> IOTabControlViewController {
        let vc = IOTabControlViewController(
            tabControlHeight: self.tabControlHeight,
            tabTitles: self.tabTitles,
            textColor: self.textColor,
            font: self.font,
            lineColor: self.lineColor,
            lineHeight: self.lineHeight
        )
        vc.hostingController.rootView = viewForContent()
        context.coordinator.viewController = vc
        return vc
    }

    public func updateUIViewController(_ viewController: IOTabControlViewController, context: Context) {
        context.coordinator.setPage(page)
        context.coordinator.update(tabTitles: tabTitles)
        viewController.hostingController.rootView = viewForContent()
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
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
