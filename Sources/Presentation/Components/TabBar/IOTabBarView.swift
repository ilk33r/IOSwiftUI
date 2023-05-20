//
//  IOTabBarView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import IOSwiftUIInfrastructure
import SwiftUI
import UIKit

public struct IOTabBarView<Controller: IOTabBarController>: UIViewControllerRepresentable {

    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Properties
    
    private let content: () -> [IOIdentifiableView]
    private let controllerType: Controller.Type
    private let tabBarType: UITabBar.Type
    
    @Binding private var selection: Int
    @Binding private var updateViews: Bool

    // MARK: - Initialization Methods
    
    public init(
        controllerType: Controller.Type,
        tabBarType: UITabBar.Type,
        @ViewBuilder content: @escaping () -> [IOIdentifiableView]
    ) {
        self.content = content
        self.controllerType = controllerType
        self.tabBarType = tabBarType
        self._selection = Binding.constant(0)
        self._updateViews = Binding.constant(false)
    }
    
    public init(
        controllerType: Controller.Type,
        tabBarType: UITabBar.Type,
        selection: Binding<Int>,
        updateViews: Binding<Bool>,
        @ViewBuilder content: @escaping () -> [IOIdentifiableView]
    ) {
        self.content = content
        self.controllerType = controllerType
        self.tabBarType = tabBarType
        self._selection = selection
        self._updateViews = updateViews
    }

    // MARK: - Representable
    
    public func makeUIViewController(context: Context) -> Controller {
        let vc = controllerType.init(tabBarType: tabBarType)
        vc.setupViewControllers(identifiables: content())
        vc.setSelectionHandler { index in
            selection = index
        }
        return vc
    }

    public func updateUIViewController(_ viewController: Controller, context: Context) {
        if updateViews {
            viewController.setupViewControllers(identifiables: self.content())
            viewController.selectedIndex = selection
            
            thread.runOnMainThread(afterMilliSecond: 150) {
                updateViews = false
            }
        }
    }
}
