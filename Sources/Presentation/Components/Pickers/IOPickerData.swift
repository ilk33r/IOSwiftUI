//
//  IOPickerData.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.01.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOPickerData: Equatable {
    
    // MARK: - Defs
    
    public typealias DataHandler = () -> IOPickerData
    public typealias DismissHandler = () -> Void
    
    // MARK: - Properties
    
    public let doneButtonTitle: String
    public let pickerData: [IOPickerUIModel]
    
    public var handler: DismissHandler?
    
    @Binding public var selectedItem: IOPickerUIModel?
    
    // MARK: - Initialization Methods
    
    public init(
        doneButtonTitle: IOLocalizationType,
        data: [IOPickerUIModel],
        selectedItem: Binding<IOPickerUIModel?>
    ) {
        self.doneButtonTitle = doneButtonTitle.localized
        self.pickerData = data
        self._selectedItem = selectedItem
        self.handler = nil
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: IOPickerData, rhs: IOPickerData) -> Bool {
        false
    }
}
