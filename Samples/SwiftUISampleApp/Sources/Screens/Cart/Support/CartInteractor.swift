// 
//  CartInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public struct CartInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: CartEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<CartService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
