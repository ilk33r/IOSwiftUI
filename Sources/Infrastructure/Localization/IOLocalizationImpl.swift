//
//  IOLocalizationImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

open class IOLocalizationImpl: IOLocalization, IOSingleton {
    
    public typealias InstanceType = IOLocalizationImpl
    public static var _sharedInstance: IOLocalizationImpl!
    
    // MARK: - Getters
    
    open var currentLanguageCode: String {
        return self.currentLanguageCodeVal
    }
    
    open var currentLocale: Locale {
        return self.currentLocaleVal
    }
    
    open var currentLocaleType: IOLocales {
        return self.currentLocaleTypeVal
    }
    
    // MARK: - Privates
    
    private var currentLanguageCodeVal: String
    private var currentLocaleVal: Locale
    private var currentLocaleTypeVal: IOLocales
    private var bundle: Bundle!
    private var languageBundle: Bundle!
    
    // MARK: - Initialization Methods
    
    required public init() {
        let locale = Locale.current
        self.currentLocaleVal = locale
        self.currentLocaleTypeVal = IOLocales(rawValue: locale.identifier)
        self.currentLanguageCodeVal = locale.identifier.prefix(2).lowercased()
        self.initialize()
    }
    
    private func initialize() {
        self.bundle = Bundle.main
    }
    
    // MARK: - Language Methods
    
    open func availableLanguageCodes() -> [String] {
        return self.bundle.localizations
    }
    
    open func availableLocales() -> [Locale] {
        return self.availableLanguageCodes().map { Locale(identifier: $0) }
    }
    
    open func changeLanguage(locale: Locale) {
        self.currentLocaleVal = locale
        self.currentLocaleTypeVal = IOLocales(rawValue: locale.identifier)
        self.currentLanguageCodeVal = locale.identifier.prefix(2).lowercased()
        self.languageBundle = self.readLanguageBundle(code: self.currentLanguageCodeVal)
    }
    
    open func changeLanguage(type: IOLocales) {
        let locale = Locale(identifier: type.rawValue)
        self.changeLanguage(locale: locale)
    }
    
    public func changeLocalizationBundle(bundleName: String) {
        let resourcesBundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle", inDirectory: nil)
        let resourcesBundle = Bundle(path: resourcesBundlePath!)!
        if !resourcesBundle.isLoaded {
            resourcesBundle.load()
        }
        self.bundle = resourcesBundle
    }
    
    // MARK: - Accessor Methods
    
    open func string(_ key: String) -> String {
        return self.string(key, alternateText: nil)
    }
    
    open func string(_ key: String, alternateText: String?) -> String {
        if self.languageBundle == nil {
            return alternateText ?? key
        }
        
        let localizedString = self.languageBundle.localizedString(forKey: key, value: nil, table: nil)

        if !localizedString.isEmpty {
            return localizedString
        }
        
        if let alternate = alternateText {
            return alternate
        }

        return String(format: "%@.%@", self.languageBundle, key)
    }
    
    // MARK: - Privates
    
    private func readLanguageBundle(code: String) -> Bundle {
        let languageBundlePath = self.bundle.path(forResource: code, ofType: "lproj")!
        return Bundle(path: languageBundlePath)!
    }
}
