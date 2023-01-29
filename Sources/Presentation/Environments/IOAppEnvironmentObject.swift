//
//  IOAppEnvironmentObject.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Combine
import Foundation

final public class IOAppEnvironmentObject: IOAppEnvironment {
    
    // MARK: - Properties
    
    @Published public var showLoading = false
    
    public var alertData: IOAlertData? {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    public var datePickerData: IODatePickerData? {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    public var pickerData: IOPickerData? {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    public var toastData: IOToastData? {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
