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
         static let icnTabBarSearch = Image("icnTabBarSearch", bundle: Bundle.resources)
         */
        
        let tabbarItems = self.tabBar.items
        guard let firstButton = tabbarItems?[0] else {return}
        firstButton.image = UIImage(named: "icnTabBarHome", in: Bundle.resources, with: nil)
        firstButton.selectedImage = firstButton.image
        
        guard let secondButton = tabbarItems?[1] else {return}
        let cameraButtonImage = UIImage(named: "icnTabBarCamera", in: Bundle.resources, with: nil)?.withRenderingMode(.alwaysOriginal)
        secondButton.image = cameraButtonImage
        secondButton.selectedImage = secondButton.image
        
        guard let thirdButton = tabbarItems?[2] else {return}
        thirdButton.image = UIImage(named: "icnTabBarChat", in: Bundle.resources, with: nil)
        thirdButton.selectedImage = thirdButton.image
        
        guard let fourthButton = tabbarItems?[3] else {return}
        fourthButton.image = UIImage(named: "icnTabBarProfile", in: Bundle.resources, with: nil)
        fourthButton.selectedImage = fourthButton.image
    }
}

public extension TabBarController {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let cameraViewController = self.viewControllers?[1]
        if viewController.isEqual(cameraViewController) {
            self.selectionHandler?(0)
            return false
        }
        
        return true
    }
}
