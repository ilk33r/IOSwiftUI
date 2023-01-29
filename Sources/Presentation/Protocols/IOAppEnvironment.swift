//
//  IOAppEnvironment.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Combine
import Foundation
import SwiftUI

public protocol IOAppEnvironment: ObservableObject {
    
    // MARK: - Properties
    
    var alertData: IOAlertData? { get set }
    var datePickerData: IODatePickerData? { get set }
    var toastData: IOToastData? { get set }
    var pickerData: IOPickerData? { get set }
    
    // MARK: - Initialization Methods
    
    init()
}
