//
//  IOLocalizationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOLocalizationImpl: IOLocalization, IOSingleton {
    
    public typealias InstanceType = IOLocalizationImpl
    public static var _sharedInstance: IOLocalizationImpl!
    
    // MARK: - Getters
    
    public var currentLanguageCode: String {
        self._currentLanguageCode
    }
    
    public var currentLocale: Locale {
        self._currentLocale
    }
    
    public var currentLocaleType: IOLocales {
        self._currentLocaleType
    }
    
    // MARK: - Privates
    
    private var _currentLanguageCode: String
    private var _currentLocale: Locale
    private var _currentLocaleType: IOLocales
    private var bundle: Bundle!
    private var languageBundle: Bundle?
    
    // MARK: - Initialization Methods
    
    public init() {
        let locale = Locale.current
        let currentLanguageCodeVal = locale.identifier.prefix(2).lowercased()
        
        self._currentLocale = locale
        self._currentLocaleType = IOLocales(rawValue: locale.identifier)
        self._currentLanguageCode = currentLanguageCodeVal
        self.bundle = Bundle.main
        self.languageBundle = self.readLanguageBundle(code: currentLanguageCodeVal)
    }
    
    // MARK: - Language Methods
    
    public func availableLanguageCodes() -> [String] {
        self.bundle.localizations
    }
    
    public func availableLocales() -> [Locale] {
        self.availableLanguageCodes().map { Locale(identifier: $0) }
    }
    
    public func changeLanguage(locale: Locale) {
        let currentLanguageCodeVal = locale.identifier.prefix(2).lowercased()
        
        self._currentLocale = locale
        self._currentLocaleType = IOLocales(rawValue: currentLocale.identifier)
        self._currentLanguageCode = currentLanguageCodeVal
        self.languageBundle = self.readLanguageBundle(code: currentLanguageCodeVal)
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
        self.bundle = resourcesBundle
    }
    
    // MARK: - Accessor Methods
    
    public func string(_ key: String) -> String {
        self.string(key, alternateText: nil)
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

        return String(format: "%@.%@", languageBundle!, key)
    }
    
    // MARK: - Privates
    
    private func readLanguageBundle(code: String) -> Bundle? {
        if let languageBundlePath = self.bundle.path(forResource: code, ofType: "lproj") {
            return Bundle(path: languageBundlePath)!
        }
        
        return nil
    }
}
