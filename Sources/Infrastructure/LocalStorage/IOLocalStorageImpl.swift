//
//  IOLocalStorageImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOLocalStorageImpl: IOLocalStorage, IOSingleton {
    
    public typealias InstanceType = IOLocalStorageImpl
    public static var _sharedInstance: IOLocalStorageImpl!
    
    // MARK: - DI
    
    @IOInject private var configuration: IOConfiguration
    
    // MARK: - Privates
    
    private let userDefaults: UserDefaults
    
    // MARK: - Initialization Methods
    
    public init() {
        self.userDefaults = UserDefaults.standard
    }
    
    // MARK: - Getters
    
    public func allKeys() -> [String] {
        // Read all keys from user defaults
        let allKeys = userDefaults.dictionaryRepresentation().keys.map { String($0) }
        return allKeys
    }
    
    public func bool(forType type: IOStorageType) -> Bool? {
        let key = reformKey(type)
        if has(key: key) {
            return userDefaults.bool(forKey: key)
        }
        
        return nil
    }
    
    public func double(forType type: IOStorageType) -> Double? {
        let key = reformKey(type)
        if has(key: key) {
            return userDefaults.double(forKey: key)
        }
        
        return nil
    }
    
    public func int(forType type: IOStorageType) -> Int? {
        let key = reformKey(type)
        if has(key: key) {
            return userDefaults.integer(forKey: key)
        }
        
        return nil
    }
    
    public func string(forType type: IOStorageType) -> String? {
        let key = reformKey(type)
        if has(key: key) {
            return userDefaults.string(forKey: key)
        }
        
        return nil
    }
    
    // MARK: - Setters
    
    public func set(bool value: Bool, forType type: IOStorageType) {
        let key = reformKey(type)
        userDefaults.set(value, forKey: key)
        synchronize()
    }
    
    public func set(double value: Double, forType type: IOStorageType) {
        let key = reformKey(type)
        userDefaults.set(value, forKey: key)
        synchronize()
    }
    
    public func set(int value: Int, forType type: IOStorageType) {
        let key = reformKey(type)
        userDefaults.set(value, forKey: key)
        synchronize()
    }
    
    public func set(string value: String, forType type: IOStorageType) {
        let key = reformKey(type)
        userDefaults.set(value, forKey: key)
        synchronize()
    }
    
    // MARK: - Removers
    
    public func remove(type: IOStorageType) {
        let key = reformKey(type)
        userDefaults.removeObject(forKey: key)
        synchronize()
    }
    
    public func removeAllObjects() {
        allKeys().forEach({ key in
            userDefaults.removeObject(forKey: key)
        })
        
        synchronize()
    }
    
    // MARK: - Helper Methods
    
    private func has(key: String) -> Bool {
        let key = allKeys().first(where: { $0 == key })
        if key == nil {
            return false
        }
        
        return true
    }
    
    private func reformKey(_ key: IOStorageType) -> String {
        return String(format: "%@_%@", configuration.configForType(type: .localStoragePrefix), key.rawValue)
    }
    
    private func synchronize() {
        CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
    }
}
