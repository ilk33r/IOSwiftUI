// 
//  HomeInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct HomeInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: HomeEntity!
    public weak var presenter: HomePresenter?
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
