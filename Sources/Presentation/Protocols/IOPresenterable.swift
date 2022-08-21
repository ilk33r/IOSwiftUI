//
//  IOPresenterable.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation

public protocol IOPresenterableInitializer {
    
    func _initializaPresenterable(entity: IOEntity?, wireframeInput: AnyObject?)
}

public protocol IOPresenterable: ObservableObject {
    
    // MARK: - Generics
    
    associatedtype Interactor: IOInteractorable
//    associatedtype WireframeInput: HPWireframeInput
//    associatedtype WireframeOutput: HPWireframeOutput
    
    var interactor: Interactor! { get set }
//    var wireframeInput: WireframeInput? { get set }
//    var wireframeOutput: WireframeOutput! { get set }
    
    // MARK: - Initialization Methods
    
    init()
}

public extension IOPresenterable {
    
    func _initializaPresenterable(entity: IOEntity?, wireframeInput: AnyObject?) {
        let interactor = Interactor()
        interactor._presenterInstance = self
        interactor._entityInstance = entity
        
        self.interactor = interactor
        
//        self.wireframeInput = wireframeInput as? WireframeInput
//        self.wireframeOutput = WireframeOutput(view: (controller as? WireframeOutput.ControllerType)!)
    }
}
