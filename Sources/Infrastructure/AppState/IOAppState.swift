//
//  IOAppState.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOAppState {
    
    // MARK: - Publics
    
    var allKeys: [IOStorageType] { get }
    
    // MARK: - Getters
    
    func bool(forType type: IOStorageType) -> Bool?
    func double(forType type: IOStorageType) -> Double?
    func int(forType type: IOStorageType) -> Int?
    func string(forType type: IOStorageType) -> String?
    func object(forType type: IOStorageType) -> Any?
    
    // MARK: - Setters
    
    func set(bool value: Bool, forType type: IOStorageType)
    func set(double value: Double, forType type: IOStorageType)
    func set(int value: Int, forType type: IOStorageType)
    func set(string value: String, forType type: IOStorageType)
    func set(object value: Any?, forType type: IOStorageType)
    
    // MARK: - Removers
    
    func remove(type: IOStorageType)
    func removeAllObjects()
}
