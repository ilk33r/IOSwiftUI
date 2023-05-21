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
    
    var entity: Entity! { get set }
    var presenter: (any IOPresenterable)? { get set }
    
    // MARK: - DI
    
    var appState: IOAppState { get }
    var eventProcess: IOEventProcess { get }
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
    var eventProcess: IOEventProcess { IODIContainerImpl.get(IOEventProcess.self) }
    var fileCache: IOFileCache { IODIContainerImpl.get(IOFileCache.self) }
    var configuration: IOConfiguration { IODIContainerImpl.get(IOConfiguration.self) }
    var localStorage: IOLocalStorage { IODIContainerImpl.get(IOLocalStorage.self) }
    
    // MARK: - Initialization Methods
    
    init(entityInstance: Any!, presenterInstance: AnyObject!) {
        self.init()
        self.entity = entityInstance as? Entity
        self.presenter = presenterInstance as? (any IOPresenterable)
    }
    
    // MARK: - Alert
    
    @discardableResult
    @MainActor
    func showAlertAsync(handler: () -> IOAlertData) async -> Int {
        await presenter?.showAlertAsync(handler: handler) ?? 0
    }
}
