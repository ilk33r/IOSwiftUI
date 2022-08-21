//
//  IOController.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public protocol IOController: View {
    
    // MARK: - Generics
    
    associatedtype Presenter: IOPresenterable
    
    // MARK: - Properties
    
    var presenter: Presenter { get set }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter)
}

public extension IOController {
    
    init(presenter: Presenter) {
        self.init(presenter: presenter)
    }
}
