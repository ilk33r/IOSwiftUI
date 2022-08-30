//
//  TabBarController.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIComponents
import UIKit

final public class TabBarController: IOTabBarController {
    
    // MARK: - View Lifecycle
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    // MARK: - Controller Methods
    
    public override func setupViewControllers(identifiables: [IdentifiableView]) {
        super.setupViewControllers(identifiables: identifiables)
        
        /*
         static let icnTabBarCamera = Image("icnTabBarCamera", bundle: Bundle.resources)
         static let icnTabBarChat = Image("icnTabBarChat", bundle: Bundle.resources)
         static let icnTabBarHome = Image("icnTabBarHome", bundle: Bundle.resources)
         static let icnTabBarProfile = Image("icnTabBarProfile", bundle: Bundle.resources)
         static let icnTabBarSearch = Image("icnTabBarSearch", bundle: Bundle.resources)
         */
        
        let tabbarItems = self.tabBar.items
        guard let firstButton = tabbarItems?[0] else {return}
        let cameraButtonImage = UIImage(named: "icnTabBarCamera", in: Bundle.resources, with: nil)?.withRenderingMode(.alwaysOriginal)
        firstButton.image = cameraButtonImage
        firstButton.selectedImage = cameraButtonImage
        
        guard let secondButton = tabbarItems?[1] else {return}
        secondButton.image = UIImage(named: "icnTabBarChat", in: Bundle.resources, with: nil)
        secondButton.selectedImage = secondButton.image
        
        guard let thirdButton = tabbarItems?[2] else {return}
        thirdButton.image = UIImage(named: "icnTabBarProfile", in: Bundle.resources, with: nil)
        thirdButton.selectedImage = thirdButton.image
    }
}

extension TabBarController {
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let cameraViewController = self.viewControllers?[0]
        if viewController.isEqual(cameraViewController) {
            self.selectionHandler?(0)
            return false
        }
        
        return true
    }
}
