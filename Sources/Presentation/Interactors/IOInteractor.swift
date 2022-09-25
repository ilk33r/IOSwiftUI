//
//  IOInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure

open class IOInteractor<TPresenter: IOPresenterable, TEntity: IOEntity>: IOInteractorable {
    
    // MARK: - Interactorable
    
    public var _entityInstance: Any!
    public weak var _presenterInstance: AnyObject!
    
    public typealias Entity = TEntity
    public typealias Presenter = TPresenter
    
    // MARK: - DI
    
    @IOInject private var _appState: IOAppStateImpl
    @IOInject private var _configuration: IOConfigurationImpl
    @IOInject private var _localization: IOLocalizationImpl
    @IOInject private var _localStorage: IOLocalStorageImpl
    @IOInject private var _service: IOServiceProviderImpl
    
    open var appState: IOAppState { self._appState }
    open var configuration: IOConfiguration { self._configuration }
    open var localization: IOLocalization { self._localization }
    open var localStorage: IOLocalStorage { self._localStorage }
    open var service: IOServiceProvider { self._service }
    
    // MARK: - Init
    
    required public init() {
    }
}
