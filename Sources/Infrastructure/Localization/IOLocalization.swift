//
//  IOLocalization.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOLocalization {
    
    // MARK: - Getters
    
    var currentLanguageCode: String { get }
    var currentLocale: Locale { get }
    var currentLocaleType: IOLocales { get }
    
    // MARK: - Initialization
    
    init()
    
    // MARK: - Language Methods
    
    func availableLanguageCodes() -> [String]
    func availableLocales() -> [Locale]
    func changeLanguage(locale: Locale)
    func changeLanguage(type: IOLocales)
    func changeLocalizationBundle(bundleName: String)
    
    // MARK: - Accessor Methods
    
    func string(_ key: String) -> String
    func string(_ key: String, alternateText: String?) -> String
}
