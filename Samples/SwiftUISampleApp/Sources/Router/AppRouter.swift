//
//  AppRouter.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIRouter
import SwiftUISampleAppScreensShared
import SwiftUISampleAppScreensSplash
import SwiftUISampleAppScreensLogin
import SwiftUISampleAppScreensRegister

@objc(AppRouter)
final public class AppRouter: NSObject, IORouterProtocol {
    
    public static var _screens: [String : any IOController.Type] = [
        "SplashView": SplashView.self,
        "LoginView": LoginView.self
    ]
    
    public static func _instance(controllerName: String, entity: IOEntity?) -> any IOController {
        guard let controller = self._screens[controllerName] else {
            fatalError("View with name \(controllerName) could not found")
        }
        
        return controller.init(entity: entity)
    }
}
