//
//  TestAssembly.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUITestInfrastructure

public struct TestAssembly: IOAssembly {
    
    public static func configureDI(container: IODIContainer) {
        container.register(class: IOThread.self) { IOThreadImpl() }
        container.register(class: IOValidator.self) { IOValidatorImpl() }
        container.register(class: IOAlertPresenter.self) { IOAlertPresenterImpl() }
        container.register(class: IOBottomSheetPresenter.self) { IOBottomSheetPresenterImpl() }
        
        container.register(singleton: IOAppleSetting.self) { IOAppleSettingImpl.self }
        container.register(singleton: IOAppState.self) { IOAppStateImpl.self }
        container.register(singleton: IOConfiguration.self) { IOConfigurationImpl.self }
        container.register(singleton: IOFileCache.self) { IOFileCacheImpl.self }
        container.register(singleton: IOLocalization.self) { IOLocalizationImpl.self }
        container.register(singleton: IOLocalStorage.self) { IOLocalStorageImpl.self }
        container.register(singleton: IOMapper.self) { IOMapperImpl.self }
        container.register(singleton: IOHTTPLogger.self) { IOHTTPLoggerImpl.self }
        container.register(singleton: IOEventProcess.self, impl: { IOEventProcessImpl.self })
        
        container.register(singleton: IOHTTPClient.self) { IOHTTPClientTestImpl.self }
    }
}
