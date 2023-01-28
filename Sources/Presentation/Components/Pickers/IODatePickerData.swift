//
//  IODatePickerData.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.01.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IODatePickerData: Equatable {
    
    // MARK: - Defs
    
    public typealias DataHandler = () -> IODatePickerData
    public typealias DismissHandler = () -> Void
    
    // MARK: - Properties
    
    public let dateFormat: String
    public let doneButtonTitle: String
    
    public var handler: DismissHandler?
    
    @Binding public var selectedItem: Date?
    @Binding public var selectedItemString: String
    
    // MARK: - Initialization Methods
    
    public init(
        doneButtonTitle: IOLocalizationType,
        dateFormat: String,
        selectedItem: Binding<Date?>,
        selectedItemString: Binding<String>
    ) {
        self.doneButtonTitle = doneButtonTitle.localized
        self.dateFormat = dateFormat
        self._selectedItem = selectedItem
        self._selectedItemString = selectedItemString
        self.handler = nil
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: IODatePickerData, rhs: IODatePickerData) -> Bool {
        return false
    }
}
