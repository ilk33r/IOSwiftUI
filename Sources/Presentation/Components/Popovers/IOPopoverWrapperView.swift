//
//  IOPopoverWrapperView.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import SwiftUI

public struct IOPopoverWrapperView<Content: View>: UIViewControllerRepresentable {
    
    // MARK: - Privates
    
    @Binding private var show: Bool
    
    private let content: () -> Content
    private let size: CGSize?
    
    // MARK: - Controller Representable
    
    public init(
        show: Binding<Bool>,
        size: CGSize?,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._show = show
        self.content = content
        self.size = size
    }
    
    public func makeUIViewController(context: Context) -> IOPopoverWrapperViewController<Content> {
        return IOPopoverWrapperViewController(
            size: size,
            content: content
        ) {
            show = false
        }
    }
    
    public func updateUIViewController(_ viewController: IOPopoverWrapperViewController<Content>, context: Context) {
        viewController.updateSize(size)
        
        if show {
            viewController.showPopover()
        } else {
            viewController.hidePopover()
        }
    }
}
