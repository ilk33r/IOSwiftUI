//
//  SplashPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

final public class SplashPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public typealias Interactor = SplashInteractor
    
    public var interactor: SplashInteractor!
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
