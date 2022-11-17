//
//  IOSwiftUISampleAppDelegate.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation
import UIKit
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUIApplication
import SwiftUISampleAppPresentation

final class IOSwiftUISampleAppDelegate: IOAppDelegate {
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfiguration
    @IOInject private var fileCache: IOFileCache
    @IOInject private var localization: IOLocalization
    
    // MARK: - Configuration
    
    override func configureApplication() {
        super.configureApplication()
        
        self.localization.setLocalizationBundle(bundleName: "SwiftUISampleApp_SwiftUISampleAppResources")
        self.localization.changeLanguage(type: self.configuration.defaultLocale)
        
        self.httpClient.setDefaultHTTPHeaders(headers: [
            "X-IO-AUTHORIZATION": configuration.configForType(type: .networkingAuthorizationHeader)
        ])
        
        let cacheFileBeforeDate = Date()
        self.fileCache.removeFiles(beforeDate: cacheFileBeforeDate.date(bySubtractingDays: 3)!)
    }
    
    override func configureDI(container: IODIContainer) {
        super.configureDI(container: container)
        
        container.register(class: IOIndicatorPresenter.self) {
            IOIndicatorPresenterImpl {
                IndicatorView()
                    .transition(.opacity)
            }
        }
        
        IOFontType.registerFontsIfNecessary(Bundle.resources)
        AppTheme.applyTheme()
    }
}
