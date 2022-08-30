//
//  IOTabBarController.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import UIKit
import SwiftUI

open class IOTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Defs
    
    public typealias SelectionHandler = (_ index: Int) -> Void
    
    // MARK: - Privates
    
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
    
    // MARK: - Controller Methods
    
    public func setSelectionHandler(_ handler: SelectionHandler?) {
        self.selectionHandler = handler
    }
    
    open func setupViewControllers(identifiables: [IdentifiableView]) {
        var viewsControllers = [UIHostingController<AnyView>]()
        
        for identifiable in identifiables {
            let hostingController = UIHostingController(rootView: identifiable.view)
            viewsControllers.append(hostingController)
        }
        
        self.viewControllers = viewsControllers
    }
    
    // MARK: - Delegate
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controllerIndex = self.viewControllers?.firstIndex(where: { $0.isEqual(viewController) }) else { return }
        if controllerIndex >= 0 {
            self.selectionHandler?(controllerIndex)
        }
    }
}
