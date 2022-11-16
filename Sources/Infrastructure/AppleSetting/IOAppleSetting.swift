//
//  IOAppleSetting.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.11.2022.
//

import Foundation
import IOSwiftUICommon

public protocol IOAppleSetting {
    
    // MARK: - Defs
    
    typealias ChangeListenerID = Int
    typealias ChangeHandler = () -> Void
    
    // MARK: - Getters
    
    func bool(for type: IOAppleSettingType) -> Bool
    func string(for type: IOAppleSettingType) -> String?
    
    // MARK: - Setters
    
    func set(_ bool: Bool, for type: IOAppleSettingType)
    func set(_ string: String?, for type: IOAppleSettingType)
    
    // MARK: - Listeners
    
    @discardableResult
    func addListener(handler: ChangeHandler?) -> ChangeListenerID
    func removeListener(id: ChangeListenerID)
}
