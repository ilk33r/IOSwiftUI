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
import SwiftUISampleAppInfrastructure
import SwiftUISampleAppPresentation

final class IOSwiftUISampleAppDelegate: IOAppDelegate {
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfiguration
    @IOInject private var localization: IOLocalization
    
    // MARK: - Configuration
    
    override func configureApplication() {
        super.configureApplication()
        
        self.localization.setLocalizationBundle(bundleName: "SwiftUISampleApp_SwiftUISampleAppResources")
        self.localization.changeLanguage(type: self.configuration.defaultLocale)
        
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
        
        container.register(class: IOPickerPresenter.self) {
            IOPickerPresenterImpl { data in
                IODefaultPickerView(data: data)
                    .backgroundColor(.colorImage)
            } datePickerView: { data in
                IODefaultDatePickerView(data: data)
                    .backgroundColor(.colorImage)
            }
        }
        
        container.register(class: IOToastPresenter.self) {
            IOToastPresenterImpl { data in
                IOToastView(
                    data,
                    successBackgroundColor: .colorSuccess,
                    errorBackgroundColor: .colorTabEnd,
                    warningBackgroundColor: .yellow,
                    infoBackgroundColor: .colorImage,
                    successTextColor: .black,
                    errorTextColor: .colorImage,
                    warningTextColor: .colorImage,
                    infoTextColor: .black,
                    titleFont: .systemSemibold(14),
                    messageFont: .systemRegular(14)
                )
            }
        }
        
        container.register(singleton: CartManager.self) { CartManagerImpl.self }
        
        IOFontType.registerFontsIfNecessary(Bundle.resources)
        AppTheme.applyTheme()
    }
}
