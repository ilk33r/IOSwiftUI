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
    var localization: IOLocalization { get }
    var localStorage: IOLocalStorage { get }
    
    // MARK: - Initialization Methods
    
    init()
    init(entityInstance: Any!, presenterInstance: AnyObject!)
}

public extension IOInteractor {
    
    // MARK: - DI
    
    var appState: IOAppState { IOAppStateImpl.shared }
    var fileCache: IOFileCache { IOFileCacheImpl.shared }
    var configuration: IOConfiguration { IOConfigurationImpl.shared }
    var localization: IOLocalization { IOLocalizationImpl.shared }
    var localStorage: IOLocalStorage { IOLocalStorageImpl.shared }
    
    // MARK: - Initialization Methods
    
    init(entityInstance: Any!, presenterInstance: AnyObject!) {
        self.init()
        self.entity = entityInstance as? Entity
        self.presenter = presenterInstance as? Presenter
    }
}
