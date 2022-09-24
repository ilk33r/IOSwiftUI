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
        IOLogger.verbose("verbose log")
        IOLogger.info("info log")
        IOLogger.debug("debug log")
        IOLogger.warning("warning log")
        IOLogger.error("error log")
    }
}
