//
//  IOPageView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

public struct IOPageView<Content: View>: UIViewControllerRepresentable {

    private var content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public func makeUIViewController(context: Context) -> IOPageViewController {
        let vc = IOPageViewController()
        vc.hostingController.rootView = AnyView(self.content())
        return vc
    }

    public func updateUIViewController(_ viewController: IOPageViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())
    }
}
