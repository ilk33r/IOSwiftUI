//
//  IOBaseAppRouter.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUIPresentation

@objc(IOBaseAppRouter)
final public class IOBaseAppRouter: NSObject, IORouterProtocol {
    
    public static var _screens: [String: any IOController.Type] = [:]
    
    public static func _instance(controllerName: String, entity: IOEntity?) -> any IOController {
        guard let controller = self._screens["controllerName"] else {
            fatalError("View with name \(controllerName) could not found")
        }
        
        return controller.init(entity: entity)
    }
}
