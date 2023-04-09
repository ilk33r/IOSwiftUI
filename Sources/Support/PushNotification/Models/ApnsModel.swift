//
//  ApnsModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.04.2023.
//

import Foundation
import IOSwiftUICommon

public protocol ApnsModel: Codable {
    
    var _alert: IOJsonProperty<ApnsAlertModel> { get set }
    var _badge: IOJsonProperty<Int> { get set }
    var _category: IOJsonProperty<String> { get set }
    var _sound: IOJsonProperty<String> { get set }
}

public extension ApnsModel {
    
    var alert: ApnsAlertModel? {
        get {
            _alert.wrappedValue
        }
        set {
            _alert.wrappedValue = newValue
        }
    }
    
    var badge: Int? {
        get {
            _badge.wrappedValue
        }
        set {
            _badge.wrappedValue = newValue
        }
    }
    
    var category: String? {
        get {
            _category.wrappedValue
        }
        set {
            _category.wrappedValue = newValue
        }
    }
    
    var sound: String? {
        get {
            _sound.wrappedValue
        }
        set {
            _sound.wrappedValue = newValue
        }
    }
}
