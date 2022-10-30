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
        return self.currentLanguageCodeVal
    }
    
    public var currentLocale: Locale {
        return self.currentLocaleVal
    }
    
    public var currentLocaleType: IOLocales {
        return self.currentLocaleTypeVal
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
        return self.bundle.localizations
    }
    
    public func availableLocales() -> [Locale] {
        return self.availableLanguageCodes().map { Locale(identifier: $0) }
    }
    
    public func changeLanguage(locale: Locale) {
        Self._sharedInstance = IOLocalizationImpl(currentLocale: locale, bundle: self.bundle)
    }
    
    public func changeLanguage(type: IOLocales) {
        let locale = Locale(identifier: type.rawValue)
        self.changeLanguage(locale: locale)
    }
    
    public func setLocalizationBundle(bundleName: String) {
        let resourcesBundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle", inDirectory: nil)
        let resourcesBundle = Bundle(path: resourcesBundlePath!)!
        if !resourcesBundle.isLoaded {
            resourcesBundle.load()
        }
        Self._sharedInstance = IOLocalizationImpl(currentLocale: self.currentLocaleVal, bundle: resourcesBundle)
    }
    
    // MARK: - Accessor Methods
    
    public func string(_ key: String) -> String {
        return self.string(key, alternateText: nil)
    }
    
    public func string(_ key: String, alternateText: String?) -> String {
        if self.languageBundle == nil {
            return alternateText ?? key
        }
        
        let localizedString = self.languageBundle!.localizedString(forKey: key, value: nil, table: nil)
        if !localizedString.isEmpty {
            return localizedString
        }
        
        if let alternate = alternateText {
            return alternate
        }

        return String(format: "%@.%@", self.languageBundle!, key)
    }
    
    // MARK: - Privates
    
    private func readLanguageBundle(code: String) -> Bundle? {
        if let languageBundlePath = self.bundle.path(forResource: code, ofType: "lproj") {
            return Bundle(path: languageBundlePath)!
        }
        
        return nil
    }
}
