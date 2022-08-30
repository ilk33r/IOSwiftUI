//
//  AppTheme.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import UIKit
import SwiftUI
import IOSwiftUIPresentation

public struct AppTheme {
    
    // MARK: - Theme
    
    public static func applyTheme() {
        applyNavigationBarTheme()
        apllyTabBarTheme()
    }
    
    // MARK: - Toolbars
    
    private static func apllyTabBarTheme() {
        let tabBarAppeareance = UITabBarAppearance()
        tabBarAppeareance.configureWithOpaqueBackground()
        tabBarAppeareance.shadowImage = UIImage()
        tabBarAppeareance.shadowColor = Color.colorPassthrought.convertUI()
        tabBarAppeareance.backgroundColor = .white
        tabBarAppeareance.selectionIndicatorTintColor = Color.colorTabEnd.convertUI()
        
        UITabBar.appearance().standardAppearance = tabBarAppeareance
        UITabBar.appearance().tintColor = Color.colorTabEnd.convertUI()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppeareance
        }
    }
    
    private static func applyNavigationBarTheme() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barStyle = .default
        navigationBarAppearance.barTintColor = .clear
        navigationBarAppearance.tintColor = .black
        navigationBarAppearance.isTranslucent = true
        navigationBarAppearance.shadowImage = nil
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundImage = nil
        appearance.shadowImage = nil
//        appearance.titleTextAttributes = [
//            .font: IOFontType.regular(16).rawValue as Any,
//            .foregroundColor: UIColor.black as Any
//        ]
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 24, vertical: 2)
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.left")!, transitionMaskImage: nil)
        appearance.backButtonAppearance.normal.backgroundImagePositionAdjustment = UIOffset(horizontal: 24, vertical: 2)
        
        navigationBarAppearance.standardAppearance = appearance
        navigationBarAppearance.scrollEdgeAppearance = appearance
    }
}
