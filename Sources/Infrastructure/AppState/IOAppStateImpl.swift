//
//  IOAppStateImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

public struct IOAppStateImpl: IOAppState, IOSingleton {
    
    public typealias InstanceType = IOAppStateImpl
    public static var _sharedInstance: IOAppStateImpl!
    
    // MARK: - Publics
    
    public var allKeys: [IOStorageType] {
        Array(stateObject.values.keys)
    }
    
    public var buildNumber: Int { stateObject.buildNumber }
    public var bundleIdentifier: String { stateObject.bundleIdentifier }
    public var targetName: String { stateObject.targetName }
    public var version: String { stateObject.version }
    
    // MARK: - Privates
    
    final private class StateObject {
        
        var buildNumber: Int
        var bundleIdentifier: String
        var targetName: String
        var version: String
        var values: [IOStorageType: Any]
        
        init() {
            let infoDictionary = Bundle.main.infoDictionary
            self.buildNumber = Int(infoDictionary?[kCFBundleVersionKey as String] as? String ?? "0") ?? 0
            self.bundleIdentifier = infoDictionary?[kCFBundleIdentifierKey as String] as? String ?? ""
            self.targetName = infoDictionary?[kCFBundleExecutableKey as String] as? String ?? ""
            self.version = infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            self.values = [:]
        }
    }
    
    private let stateObject: StateObject
    private let queue: DispatchQueue

    // MARK: - Initialization Methods
    
    public init() {
        self.stateObject = StateObject()
        self.queue = DispatchQueue(label: "com.ioswiftui.infrastructure.appState")
    }

    // MARK: - Getters
    
    public func bool(forType type: IOStorageType) -> Bool? {
        stateObject.values[type] as? Bool
    }
    
    public func double(forType type: IOStorageType) -> Double? {
        stateObject.values[type] as? Double
    }
    
    public func int(forType type: IOStorageType) -> Int? {
        stateObject.values[type] as? Int
    }
    
    public func string(forType type: IOStorageType) -> String? {
        stateObject.values[type] as? String
    }
    
    public func object(forType type: IOStorageType) -> Any? {
        stateObject.values[type]
    }
    
    // MARK: - Setters
    
    public func set(bool value: Bool, forType type: IOStorageType) {
        queue.sync {
            stateObject.values[type] = value
        }
    }
    
    public func set(double value: Double, forType type: IOStorageType) {
        queue.sync {
            stateObject.values[type] = value
        }
    }
    
    public func set(int value: Int, forType type: IOStorageType) {
        queue.sync {
            stateObject.values[type] = value
        }
    }
    
    public func set(string value: String, forType type: IOStorageType) {
        queue.sync {
            stateObject.values[type] = value
        }
    }
    
    public func set(object value: Any?, forType type: IOStorageType) {
        if let val = value {
            queue.sync {
                stateObject.values[type] = val
            }
            
            return
        }
        
        queue.sync {
            _ = stateObject.values.removeValue(forKey: type)
        }
    }
    
    // MARK: - Removers
    
    public func remove(type: IOStorageType) {
        queue.sync {
            _ = stateObject.values.removeValue(forKey: type)
        }
    }
    
    public func removeAllObjects() {
        queue.sync {
            stateObject.values.removeAll()
        }
    }
}
