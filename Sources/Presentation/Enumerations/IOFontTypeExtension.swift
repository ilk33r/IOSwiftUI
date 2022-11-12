//
//  IOFontTypeExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import UIKit

public extension IOFontType {
    
    @IOInject private static var appState: IOAppStateImpl
    
    static func registerFontsIfNecessary(_ bundle: Bundle) {
        if Self.appState.bool(forType: .fontsRegistered) ?? false {
            return
        }
        
        let fonts = bundle.paths(forResourcesOfType: "ttf", inDirectory: nil)
        fonts.forEach { fontPath in
            let fontUrl = URL(fileURLWithPath: fontPath)
            Self.registerFont(from: fontUrl)
        }
        
        Self.appState.set(bool: true, forType: .fontsRegistered)
    }
    
    private static func registerFont(from url: URL) {
        guard let fontDataProvider = CGDataProvider(url: url as CFURL) else { return }
        let font = CGFont(fontDataProvider)
        var error: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(font!, &error) else { return }
    }
}
