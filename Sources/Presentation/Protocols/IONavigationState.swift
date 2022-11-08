//
//  IONavigationState.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Combine
import Foundation
import SwiftUI

public protocol IONavigationState: ObservableObject {
    
    var alertData: IOAlertData! { get set }
    var showAlert: CurrentValueSubject<Bool, Never> { get set }
}
