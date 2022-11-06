//
//  IOLocalizationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOLocalizationImpl: IOLocalization, IOSingleton {
    
    public typealias InstanceType = IOLocalizationImpl
    public static var _sharedInstance: IOLocalizationImpl!
    
    // MARK: - Getters
    
    public var currentLanguageCode: String {
        return currentLanguageCodeVal
    }
    
    public var currentLocale: Locale {
        return currentLocaleVal
    }
    
    public var currentLocaleType: IOLocales {
        return currentLocaleTypeVal
    }
    
    // MARK: - Privates
    
    private var currentLanguageCodeVal: String
    private var currentLocaleVal: Locale
    private var currentLocaleTypeVal: IOLocales
    private var bundle: Bundle!
    private var languageBundle: Bundle?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.init(currentLocale: Locale.current, bundle: Bundle.main)
    }
    
    private init(
        currentLocale: Locale,
        bundle: Bundle
    ) {
        let currentLanguageCodeVal = currentLocale.identifier.prefix(2).lowercased()
        
        self.currentLocaleVal = currentLocale
        self.currentLocaleTypeVal = IOLocales(rawValue: currentLocale.identifier)
        self.currentLanguageCodeVal = currentLanguageCodeVal
        self.bundle = bundle
        self.languageBundle = self.readLanguageBundle(code: currentLanguageCodeVal)
    }
    
    // MARK: - Language Methods
    
    public func availableLanguageCodes() -> [String] {
        return bundle.localizations
    }
    
    public func availableLocales() -> [Locale] {
        return availableLanguageCodes().map { Locale(identifier: $0) }
    }
    
    public func changeLanguage(locale: Locale) {
        Self._sharedInstance = IOLocalizationImpl(currentLocale: locale, bundle: bundle)
    }
    
    public func changeLanguage(type: IOLocales) {
        let locale = Locale(identifier: type.rawValue)
        changeLanguage(locale: locale)
    }
    
    public func setLocalizationBundle(bundleName: String) {
        let resourcesBundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle", inDirectory: nil)
        let resourcesBundle = Bundle(path: resourcesBundlePath!)!
        if !resourcesBundle.isLoaded {
            resourcesBundle.load()
        }
        Self._sharedInstance = IOLocalizationImpl(currentLocale: currentLocaleVal, bundle: resourcesBundle)
    }
    
    // MARK: - Accessor Methods
    
    public func string(_ key: String) -> String {
        return string(key, alternateText: nil)
    }
    
    public func string(_ key: String, alternateText: String?) -> String {
        if languageBundle == nil {
            return alternateText ?? key
        }
        
        let localizedString = languageBundle!.localizedString(forKey: key, value: nil, table: nil)
        if !localizedString.isEmpty {
            return localizedString
        }
        
        if let alternate = alternateText {
            return alternate
        }

        return String(format: "%@.%@", languageBundle!, key)
    }
    
    // MARK: - Privates
    
    private func readLanguageBundle(code: String) -> Bundle? {
        if let languageBundlePath = bundle.path(forResource: code, ofType: "lproj") {
            return Bundle(path: languageBundlePath)!
        }
        
        return nil
    }
}
