//
//  IOAppStateImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOAppStateImpl: IOAppState, IOSingleton {
    
    public typealias InstanceType = IOAppStateImpl
    public static var _sharedInstance: IOAppStateImpl!
    
    // MARK: - Publics
    
    public var allKeys: [IOStorageType] {
        return Array(self.values.keys)
    }
    
    public var buildNumber: Int { self._buildNumber }
    public var bundleIdentifier: String { self._bundleIdentifier }
    public var targetName: String { self._targetName }
    public var version: String { self._version }
    
    // MARK: - Privates
    
    private var _buildNumber: Int
    private var _bundleIdentifier: String
    private var _targetName: String
    private var _version: String
    private var values: [IOStorageType: Any]

    // MARK: - Initialization Methods
    
    public required init() {
        let infoDictionary = Bundle.main.infoDictionary
        self._buildNumber = Int(infoDictionary?[kCFBundleVersionKey as String] as? String ?? "0") ?? 0
        self._bundleIdentifier = infoDictionary?[kCFBundleIdentifierKey as String] as? String ?? ""
        self._targetName = infoDictionary?[kCFBundleExecutableKey as String] as? String ?? ""
        self._version = infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        self.values = [:]
    }

    // MARK: - Getters
    
    public func bool(forType type: IOStorageType) -> Bool? {
        return self.values[type] as? Bool
    }
    
    public func double(forType type: IOStorageType) -> Double? {
        return self.values[type] as? Double
    }
    
    public func int(forType type: IOStorageType) -> Int? {
        return self.values[type] as? Int
    }
    
    public func string(forType type: IOStorageType) -> String? {
        return self.values[type] as? String
    }
    
    public func object(forType type: IOStorageType) -> Any? {
        return self.values[type]
    }
    
    // MARK: - Setters
    
    public func set(bool value: Bool, forType type: IOStorageType) {
        self.values[type] = value
    }
    
    public func set(double value: Double, forType type: IOStorageType) {
        self.values[type] = value
    }
    
    public func set(int value: Int, forType type: IOStorageType) {
        self.values[type] = value
    }
    
    public func set(string value: String, forType type: IOStorageType) {
        self.values[type] = value
    }
    
    public func set(object value: Any?, forType type: IOStorageType) {
        if let val = value {
            self.values[type] = val
            return
        }
        
        self.values.removeValue(forKey: type)
    }
    
    // MARK: - Removers
    
    public func remove(type: IOStorageType) {
        self.values.removeValue(forKey: type)
    }
    
    public func removeAllObjects() {
        self.values.removeAll()
    }
}
