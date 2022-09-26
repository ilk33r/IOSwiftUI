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
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Roboto-Medium", size: 17) as Any,
            .foregroundColor: UIColor.black as Any
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Roboto-Regular", size: 36) as Any,
            .foregroundColor: UIColor.black as Any
        ]
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 24, vertical: 2)
        let backButtonImage = UIImage(systemName: "chevron.left")!.withTintColor(.black, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance.normal.backgroundImagePositionAdjustment = UIOffset(horizontal: 24, vertical: 2)
        
        navigationBarAppearance.standardAppearance = appearance
        navigationBarAppearance.scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationBarAppearance.compactScrollEdgeAppearance = appearance
        }
    }
}
