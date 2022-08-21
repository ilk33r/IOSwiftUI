//
//  IOInteractorable.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

@objc public protocol IOBaseInteractorable: AnyObject {
    
    var _entityInstance: Any! { get set }
    weak var _presenterInstance: AnyObject! { get set }
    
    init()
}

public protocol IOInteractorable: IOBaseInteractorable {
    
    associatedtype Entity: IOEntity
    associatedtype Presenter: IOPresenterable
    
    var entity: Entity! { get }
    var presenter: Presenter? { get }
}

public extension IOInteractorable {
    
    var entity: Entity! { self._entityInstance as? Entity }
    var presenter: Presenter? { self._presenterInstance as? Presenter  }
}
