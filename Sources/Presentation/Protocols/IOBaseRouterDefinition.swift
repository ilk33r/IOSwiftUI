//
//  IOBaseRouterDefinition.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation

public protocol IOBaseRouterDefinition {

    var entity: IOEntity? { get }
    var viewName: String { get }
}
