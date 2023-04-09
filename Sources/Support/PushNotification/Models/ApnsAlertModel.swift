//
//  ApnsAlertModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.04.2023.
//

import Foundation
import IOSwiftUICommon

public protocol ApnsAlertModel: Codable {
    
    var _body: IOJsonProperty<String> { get set }
    var _title: IOJsonProperty<String>  { get set }
}

public extension ApnsAlertModel {
    
    var body: String? {
        get {
            _body.wrappedValue
        }
        set {
            _body.wrappedValue = newValue
        }
    }
    
    var title: String? {
        get {
            _title.wrappedValue
        }
        set {
            _title.wrappedValue = newValue
        }
    }
}
