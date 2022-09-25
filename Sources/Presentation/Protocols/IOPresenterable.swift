//
//  IOPresenterable.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI

public protocol IOPresenterableInitializer {
    
    func _initializaPresenterable(entity: IOEntity?)
}

public protocol IOPresenterable: ObservableObject {
    
    // MARK: - Generics
    
    associatedtype Environment: IOAppEnvironment
    associatedtype Interactor: IOInteractorable
    
    var environment: EnvironmentObject<Environment>! { get set }
    var interactor: Interactor! { get set }
    
    // MARK: - Initialization Methods
    
    init()
}

public extension IOPresenterable {
    
    func _initializaPresenterable(entity: IOEntity?) {
        let interactor = Interactor()
        interactor._presenterInstance = self
        interactor._entityInstance = entity
        
        self.interactor = interactor
    }
}
