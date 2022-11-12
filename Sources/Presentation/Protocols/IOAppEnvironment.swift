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
    
    // MARK: - Initialization Methods
    
    init()
}
