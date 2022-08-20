//
//  IOAppConfiguration.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct IOAppConfiguration: IOConfigurationObject {
    
    @IOInject private var configurationImpl: IOConfigurationImpl
    @IOInject private var localizationImpl: IOLocalizationImpl
    
    public var configData: [IOEnvironmentType: [IOConfigurationType: String]] {
        return [
            .debug: [
                .apiURL: "https://google.com",
                .apiTimeout: "90",
                .localStoragePrefix: "swiftuisampleapp"
            ],
            .release: [
                .apiURL: "https://google.com",
                .apiTimeout: "30",
                .localStoragePrefix: "swiftuisampleapp"
            ]
        ]
    }
    
    public init(environment: IOEnvironmentType, locale: IOLocales) {
        self.configurationImpl.setConfiguration(configurations: self)
        self.configurationImpl.setEnvironment(type: environment)
        
        self.localizationImpl.changeLocalizationBundle(bundleName: "SwiftUISampleApp_SwiftUISampleAppResources")
        self.localizationImpl.changeLanguage(type: locale)
    }
}
