// 
//  SettingsPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class SettingsPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<IOAppEnvironmentObject>!
    public var interactor: SettingsInteractor!
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
