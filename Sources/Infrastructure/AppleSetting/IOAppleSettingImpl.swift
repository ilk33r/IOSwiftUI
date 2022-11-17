//
//  IOAppleSettingImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation
import IOSwiftUICommon

final public class IOAppleSettingImpl: IOAppleSetting, IOSingleton {
    
    // MARK: - Singleton
    
    public typealias InstanceType = IOAppleSettingImpl
    public static var _sharedInstance: IOAppleSettingImpl!
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private let userDefaults: UserDefaults
    
    private var listeners: [ChangeListenerID: ChangeHandler?]
    private var listenerID: ChangeListenerID
    
    // MARK: - Initiallization Methods
    
    public init() {
        self.userDefaults = UserDefaults.standard
        self.listeners = [:]
        self.listenerID = 0
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IOAppleSettingImpl.settingValueChanged(_:)),
            name: UserDefaults.didChangeNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Getters
    
    public func bool(for type: IOAppleSettingType) -> Bool {
        return self.userDefaults.bool(forKey: type.rawValue)
    }
    
    public func float(for type: IOAppleSettingType) -> Float {
        return self.userDefaults.float(forKey: type.rawValue)
    }
    
    public func string(for type: IOAppleSettingType) -> String? {
        return self.userDefaults.string(forKey: type.rawValue)
    }
    
    // MARK: - Setters
    
    public func set(_ bool: Bool, for type: IOAppleSettingType) {
        self.userDefaults.set(bool, forKey: type.rawValue)
        self.userDefaults.synchronize()
    }
    
    public func set(_ float: Float, for type: IOAppleSettingType) {
        self.userDefaults.set(float, forKey: type.rawValue)
        self.userDefaults.synchronize()
    }
    
    public func set(_ string: String?, for type: IOAppleSettingType) {
        self.userDefaults.set(string, forKey: type.rawValue)
        self.userDefaults.synchronize()
    }
    
    // MARK: - Listeners
    
    @discardableResult
    public func addListener(handler: ChangeHandler?) -> ChangeListenerID {
        self.listenerID += 1
        self.listeners[self.listenerID] = handler
        
        return self.listenerID
    }
    
    public func removeListener(id: ChangeListenerID) {
        self.listeners.removeValue(forKey: id)
    }
    
    // MARK: - Actions
    
    @objc dynamic private func settingValueChanged(_ sender: Notification!) {
        self.listeners.forEach { [weak self] _, value in
            self?.thread.runOnMainThread {
                value?()
            }
        }
    }
}
