//
//  IOTabBarView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI
import UIKit

public struct IOTabBarView<Controller: IOTabBarController>: UIViewControllerRepresentable {

    @Binding private var selection: Int
    private var content: () -> [IOIdentifiableView]
    private var controllerType: Controller.Type
    private var tabBarType: UITabBar.Type

    public init(
        controllerType: Controller.Type,
        tabBarType: UITabBar.Type,
        @ViewBuilder content: @escaping () -> [IOIdentifiableView]
    ) {
        self.content = content
        self.controllerType = controllerType
        self.tabBarType = tabBarType
        self._selection = Binding.constant(0)
    }
    
    public init(
        controllerType: Controller.Type,
        tabBarType: UITabBar.Type,
        selection: Binding<Int>,
        @ViewBuilder content: @escaping () -> [IOIdentifiableView]
    ) {
        self.content = content
        self.controllerType = controllerType
        self.tabBarType = tabBarType
        self._selection = selection
    }

    public func makeUIViewController(context: Context) -> Controller {
        let vc = controllerType.init(tabBarType: tabBarType)
        vc.setupViewControllers(identifiables: content())
        vc.setSelectionHandler { index in
            selection = index
        }
        return vc
    }

    public func updateUIViewController(_ viewController: Controller, context: Context) {
//        viewController.setupViewControllers(identifiables: self.content())
    }
}
