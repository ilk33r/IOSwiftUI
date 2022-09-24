//
//  IOLocalStorageImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOLocalStorageImpl: IOLocalStorage, IOSingleton {
    
    public typealias InstanceType = IOLocalStorageImpl
    public static var _sharedInstance: IOLocalStorageImpl!
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfigurationImpl
    
    // MARK: - Privates
    
    private let userDefaults: UserDefaults
    
    // MARK: - Initialization Methods
    
    required public init() {
        self.userDefaults = UserDefaults.standard
    }
    
    // MARK: - Getters
    
    public func allKeys() -> [String] {
        // Read all keys from user defaults
        let allKeys = self.userDefaults.dictionaryRepresentation().keys.map { String($0) }
        return allKeys
    }
    
    public func bool(forType type: IOStorageType) -> Bool? {
        let key = self.reformKey(type)
        if self.has(key: key) {
            return self.userDefaults.bool(forKey: key)
        }
        
        return nil
    }
    
    public func double(forType type: IOStorageType) -> Double? {
        let key = self.reformKey(type)
        if self.has(key: key) {
            return self.userDefaults.double(forKey: key)
        }
        
        return nil
    }
    
    public func int(forType type: IOStorageType) -> Int? {
        let key = self.reformKey(type)
        if self.has(key: key) {
            return self.userDefaults.integer(forKey: key)
        }
        
        return nil
    }
    
    public func string(forType type: IOStorageType) -> String? {
        let key = self.reformKey(type)
        if self.has(key: key) {
            return self.userDefaults.string(forKey: key)
        }
        
        return nil
    }
    
    // MARK: - Setters
    
    public func set(bool value: Bool, forType type: IOStorageType) {
        let key = self.reformKey(type)
        self.userDefaults.set(value, forKey: key)
        self.synchronize()
    }
    
    public func set(double value: Double, forType type: IOStorageType) {
        let key = self.reformKey(type)
        self.userDefaults.set(value, forKey: key)
        self.synchronize()
    }
    
    public func set(int value: Int, forType type: IOStorageType) {
        let key = self.reformKey(type)
        self.userDefaults.set(value, forKey: key)
        self.synchronize()
    }
    
    public func set(string value: String, forType type: IOStorageType) {
        let key = self.reformKey(type)
        self.userDefaults.set(value, forKey: key)
        self.synchronize()
    }
    
    // MARK: - Removers
    
    public func remove(type: IOStorageType) {
        let key = self.reformKey(type)
        self.userDefaults.removeObject(forKey: key)
        self.synchronize()
    }
    
    public func removeAllObjects() {
        self.allKeys().forEach({ [weak self] key in
            self?.userDefaults.removeObject(forKey: key)
        })
        
        self.synchronize()
    }
    
    // MARK: - Helper Methods
    
    private func has(key: String) -> Bool {
        let key = self.allKeys().first(where: { $0 == key })
        if key == nil {
            return false
        }
        
        return true
    }
    
    private func reformKey(_ key: IOStorageType) -> String {
        return String(format: "%@_%@", self.configuration.configForType(type: .localStoragePrefix), key.rawValue)
    }
    
    private func synchronize() {
        CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
    }
}
