//
//  IORouterProtocol.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation

public protocol IORouterProtocol: AnyObject {
    
    static var _screens: [String: any IOController.Type] { get }
    
    static func _instance(controllerName: String, entity: IOEntity?) -> any IOController
}
