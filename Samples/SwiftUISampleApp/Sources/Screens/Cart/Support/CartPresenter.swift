// 
//  CartPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class CartPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: CartInteractor!
    public var navigationState: StateObject<CartNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
}

#if DEBUG
extension CartPresenter {
    
    func prepareForPreview() {
        
    }
}
#endif
