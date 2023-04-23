//
//  SampleAppEnvironment.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Combine
import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

final public class SampleAppEnvironment: IOAppEnvironment {
    
    // MARK: - Properties
    
    @Published public var appScreen = AppScreen.splash
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
