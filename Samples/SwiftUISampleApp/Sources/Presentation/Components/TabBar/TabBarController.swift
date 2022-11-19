//
//  TabBarController.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
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
    
    public override func setupViewControllers(identifiables: [IOIdentifiableView]) {
        super.setupViewControllers(identifiables: identifiables)
        
        let tabbarItems = self.tabBar.items
        guard let firstButton = tabbarItems?[0] else {return}
        firstButton.image = UIImage(named: "icnTabBarHome", in: Bundle.resources, with: nil)
        firstButton.selectedImage = firstButton.image
        
        guard let secondButton = tabbarItems?[1] else {return}
        secondButton.image = UIImage(named: "icnTabBarSearch", in: Bundle.resources, with: nil)
        secondButton.selectedImage = secondButton.image
        
        guard let thirdButton = tabbarItems?[2] else {return}
        let cameraButtonImage = UIImage(named: "icnTabBarCamera", in: Bundle.resources, with: nil)?.withRenderingMode(.alwaysOriginal)
        thirdButton.image = cameraButtonImage
        thirdButton.selectedImage = thirdButton.image
        
        guard let fourthButton = tabbarItems?[3] else {return}
        fourthButton.image = UIImage(named: "icnTabBarChat", in: Bundle.resources, with: nil)
        fourthButton.selectedImage = fourthButton.image
        
        guard let fifthButton = tabbarItems?[4] else {return}
        fifthButton.image = UIImage(named: "icnTabBarProfile", in: Bundle.resources, with: nil)
        fifthButton.selectedImage = fifthButton.image
    }
}

public extension TabBarController {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let cameraViewController = self.viewControllers?[2]
        if viewController.isEqual(cameraViewController) {
            self.selectionHandler?(2)
            return false
        }
        
        return true
    }
}
