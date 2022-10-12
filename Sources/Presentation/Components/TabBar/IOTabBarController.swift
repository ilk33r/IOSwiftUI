//
//  IOTabBarController.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import UIKit
import SwiftUI
import IOSwiftUIInfrastructure

open class IOTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Defs
    
    public typealias SelectionHandler = (_ index: Int) -> Void
    
    // MARK: - Privates
    
    @IOInject private var appState: IOAppStateImpl
    
    private(set) public var selectionHandler: SelectionHandler?
    private var tabBarType: UITabBar.Type
    
    // MARK: - View Lifecycle
    
    required public init(tabBarType: UITabBar.Type) {
        self.tabBarType = tabBarType
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        self.tabBarType = UITabBar.self
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setValue(self.tabBarType.init(), forKey: "tabBar")
        self.delegate = self
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IOTabBarController.tabBarVisibilityChange(_:)),
            name: .tabBarVisibilityChangeNotification,
            object: nil
        )
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Controller Methods
    
    public func setSelectionHandler(_ handler: SelectionHandler?) {
        self.selectionHandler = handler
    }
    
    open func setupViewControllers(identifiables: [IOIdentifiableView]) {
        var viewsControllers = [UIHostingController<AnyView>]()
        
        for identifiable in identifiables {
            let hostingController = UIHostingController(rootView: identifiable.view)
            viewsControllers.append(hostingController)
        }
        
        self.viewControllers = viewsControllers
    }
    
    // MARK: - Visibilty
    
    open func hideTabBar() {
        self.tabBar.isHidden = true
    }
    
    open func showTabBar() {
        self.tabBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @objc dynamic private func tabBarVisibilityChange(_ sender: Notification) {
        if self.appState.bool(forType: .tabBarIsHidden) ?? false {
            self.hideTabBar()
        } else {
            self.showTabBar()
        }
    }
    
    // MARK: - Delegate
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controllerIndex = self.viewControllers?.firstIndex(where: { $0.isEqual(viewController) }) else { return }
        if controllerIndex >= 0 {
            self.selectionHandler?(controllerIndex)
        }
    }
}
