//
//  IOTestAssembly.swift
//  
//
//  Created by Adnan ilker Ozcan on 31.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOTestAssembly: IOAssembly {
    
    public static func configureDI(container: IODIContainer) {
        container.register(class: IOThread.self) { IOThreadImpl() }
        
        container.register(singleton: IOAppleSetting.self) { IOAppleSettingImpl.self }
        container.register(singleton: IOAppState.self) { IOAppStateImpl.self }
        container.register(singleton: IOConfiguration.self) { IOTestConfigurationImpl.self }
        container.register(singleton: IOFileCache.self) { IOFileCacheImpl.self }
        container.register(singleton: IOLocalization.self) { IOLocalizationImpl.self }
        container.register(singleton: IOLocalStorage.self) { IOLocalStorageImpl.self }
        container.register(singleton: IOMapper.self) { IOMapperImpl.self }
        container.register(singleton: IOHTTPLogger.self) { IOHTTPLoggerImpl.self }
        
        let appleSettings = container.resolve(IOAppleSetting.self)
        if appleSettings!.bool(for: .debugSimulateHTTPClient) {
            container.register(singleton: IOHTTPClient.self) { IOHTTPClientSimulationImpl.self }
        } else {
            container.register(singleton: IOHTTPClient.self) { IOHTTPClientImpl.self }
        }
    }
}
