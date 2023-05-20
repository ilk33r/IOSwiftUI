//
//  IOTabBarController.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Combine
import Foundation
import IOSwiftUIInfrastructure
import SwiftUI
import UIKit

open class IOTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Defs
    
    public typealias SelectionHandler = (_ index: Int) -> Void
    
    // MARK: - Privates
    
    @IOInject private var eventProcess: IOEventProcess
    
    private(set) public var selectionHandler: SelectionHandler?
    private var tabBarType: UITabBar.Type
    private var tabBarVisibilityCancellable: AnyCancellable?
    
    // MARK: - Initialization Methods
    
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
        
        self.tabBarVisibilityCancellable = self.eventProcess.bool(forType: .tabBarVisibility)
            .sink(receiveCompletion: { _ in
                IOLogger.debug("tabBarVisibility completed")
            }, receiveValue: { [weak self] newValue in
                if newValue ?? false {
                    self?.showTabBar()
                } else {
                    self?.hideTabBar()
                }
            })
    }
    
    deinit {
        self.tabBarVisibilityCancellable?.cancel()
        self.tabBarVisibilityCancellable = nil
    }
    
    // MARK: - Controller Methods
    
    public func setSelectionHandler(_ handler: SelectionHandler?) {
        self.selectionHandler = handler
    }
    
    open func setupViewControllers(identifiables: [IOIdentifiableView]) {
        var viewsControllers = [UIHostingController<AnyView>]()
        
        identifiables.forEach { identifiable in
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
    
    // MARK: - Delegate
    
    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controllerIndex = self.viewControllers?.firstIndex(where: { $0.isEqual(viewController) }) else { return }
        if controllerIndex >= 0 {
            self.selectionHandler?(controllerIndex)
        }
    }
}
