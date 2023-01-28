//
//  IOPickerUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.01.2023.
//

import Foundation
import SwiftUI

public struct IOPickerUIModel: Hashable, Identifiable {
    
    // MARK: - Model
    
    public let displayName: String
    
    // MARK: - Identifiable
    
    public var id: Int
    
    // MARK: - Initialization Methods
    
    public init(
        index: Int,
        displayName: String
    ) {
        self.id = index
        self.displayName = displayName
    }
    
    // MARK: - Protocols
    
    public static func == (lhs: IOPickerUIModel, rhs: IOPickerUIModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
