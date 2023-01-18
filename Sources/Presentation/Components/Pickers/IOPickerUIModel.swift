//
//  IOPickerUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.01.2023.
//

import Foundation
import SwiftUI

public struct IOPickerUIModel<Value>: Hashable, Identifiable {
    
    // MARK: - Model
    
    public let displayName: String
    public let value: Value?
    
    // MARK: - Identifiable
    
    public var id = UUID().uuidString
    
    // MARK: - Initialization Methods
    
    public init(
        displayName: String,
        valueType: Value.Type = Int.self,
        value: Value? = nil
    ) {
        self.displayName = displayName
        self.value = value
    }
    
    // MARK: - Protocols
    
    public static func == (lhs: IOPickerUIModel<Value>, rhs: IOPickerUIModel<Value>) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
