//
//  IOSettingBool.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation

@frozen @propertyWrapper public struct IOSettingBool {
    
    public var wrappedValue: Bool {
        get {
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }

    private let key: String
    
    public init(type: IOSettingType) {
        self.key = type.rawValue
    }
}
