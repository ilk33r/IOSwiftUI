//
//  IOInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public protocol IOInteractor {
    
    // MARK: - Interactorable
    
    associatedtype Entity: IOEntity
    associatedtype Presenter: IOPresenterable
    
    var entity: Entity! { get set }
    var presenter: Presenter? { get set }
    
    // MARK: - DI
    
    var appState: IOAppState { get }
    var fileCache: IOFileCache { get }
    var configuration: IOConfiguration { get }
    var localStorage: IOLocalStorage { get }
    
    // MARK: - Initialization Methods
    
    init()
    init(entityInstance: Any!, presenterInstance: AnyObject!)
}

public extension IOInteractor {
    
    // MARK: - DI
    
    var appState: IOAppState { IODIContainerImpl.get(IOAppState.self) }
    var fileCache: IOFileCache { IODIContainerImpl.get(IOFileCache.self) }
    var configuration: IOConfiguration { IODIContainerImpl.get(IOConfiguration.self) }
    var localStorage: IOLocalStorage { IODIContainerImpl.get(IOLocalStorage.self) }
    
    // MARK: - Initialization Methods
    
    init(entityInstance: Any!, presenterInstance: AnyObject!) {
        self.init()
        self.entity = entityInstance as? Entity
        self.presenter = presenterInstance as? Presenter
    }
    
    // MARK: - Alert
    
    func showAlert(handler: () -> IOAlertData) {
        presenter?.showAlert(handler: handler)
    }
}
